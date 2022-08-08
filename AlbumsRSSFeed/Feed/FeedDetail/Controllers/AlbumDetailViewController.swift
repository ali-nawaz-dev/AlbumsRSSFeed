//
//  AlbumDetailViewController.swift
//  AlbumsRSSFeed
//
//  Created by Sheikh Ali on 06/08/2022.
//

import UIKit

class AlbumDetailViewController: UIViewController {

    var coverImageView = UIImageView()
    
    var viewModel: AlbumFeedDetailViewModel
    var primaryKey: String
    
    var artistNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .gray
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0
        nameLabel.font = .body2
        return nameLabel
    }()
    
    var albumNameLabel: UILabel = {
        let albumLabel = UILabel()
        albumLabel.textColor = .black
        albumLabel.textAlignment = .left
        albumLabel.numberOfLines = 0
        albumLabel.font = .h1
        return albumLabel
    }()
    
    var albumGenereContainer: UIView = {
        let containerView = UIView()
        containerView.layer.borderColor = UIColor.blue.cgColor
        containerView.layer.borderWidth =  1
        containerView.layer.cornerRadius = 12
        return containerView
    }()
    
    var albumGenereLabel: UILabel = {
        let genereLabel = UILabel()
        genereLabel.textColor = .blue
        genereLabel.textAlignment = .left
        genereLabel.numberOfLines = 0
        genereLabel.font = .caption
        return genereLabel
    }()
    
    let visitAlbumButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.setTitle("Visit The Album", for: .normal)
        button.titleLabel?.font = .body1
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    var copyRightTextLabel: UILabel = {
        let copyRightLabel = UILabel()
        copyRightLabel.textColor = .gray
        copyRightLabel.textAlignment = .center
        copyRightLabel.numberOfLines = 0
        copyRightLabel.font = .caption
        return copyRightLabel
    }()
    
    var releaseTextLabel: UILabel = {
        let releaseLabel = UILabel()
        releaseLabel.textColor = .gray
        releaseLabel.textAlignment = .center
        releaseLabel.numberOfLines = 0
        releaseLabel.font = .caption
        return releaseLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setNavigationBar()
        viewModel.delegate = self
        viewModel.getAlbumDetail()
    }

    init(primarykey: String) {
        self.primaryKey = primarykey
        viewModel = AlbumFeedDetailViewModel(primaryKey: primarykey)
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI() {
        
        guard let model = viewModel.album else { return }
        albumNameLabel.text = model.name
        artistNameLabel.text = model.artistName
        ImageDownloader.shared.getImage(imagePath: model.artworkUrl100) { [weak self] image in
            self?.coverImageView.image = image
        }
        albumGenereLabel.text = model.genres.first?.name
        releaseTextLabel.text = "Released \(DateFormatter.string(iso: model.releaseDate))"
    }
    
    func setNavigationBar() {

        self.navigationItem.setHidesBackButton(true, animated:false)

        let backView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        backView.layer.cornerRadius = backView.bounds.height / 2
        backView.clipsToBounds = true
        
        let imageView = UIImageView(frame: backView.bounds)
        imageView.contentMode = .center

        if let imgBackArrow = UIImage(named: "back_arrow") {
            imageView.image = imgBackArrow
        }
        backView.addSubview(imageView)
        backView.applyBlurEffect()
        backView.bringSubviewToFront(imageView)
        
        let backTap = UITapGestureRecognizer(target: self, action: #selector(backToMain))
        backView.addGestureRecognizer(backTap)

        let leftBarButtonItem = UIBarButtonItem(customView: backView)
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    @objc func backToMain() {
        viewModel.viewDidDisappear()
    }
    
    fileprivate func commonInit() {
        
        view.addSubview(coverImageView)
       
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        coverImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        coverImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        coverImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 2.0/5.0).isActive = true
        
        view.addSubview(artistNameLabel)
        
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.topAnchor.constraint(equalTo: coverImageView.bottomAnchor, constant: 12).isActive = true
        artistNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        artistNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
    
        view.addSubview(albumNameLabel)
        
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor).isActive = true
        albumNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        albumNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        view.addSubview(albumGenereContainer)
        
        albumGenereContainer.translatesAutoresizingMaskIntoConstraints = false
        albumGenereContainer.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 8).isActive = true
        albumGenereContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        albumGenereContainer.addSubview(albumGenereLabel)
        
        albumGenereLabel.translatesAutoresizingMaskIntoConstraints = false
        albumGenereLabel.topAnchor.constraint(equalTo: albumGenereContainer.topAnchor, constant: 4).isActive = true
        albumGenereLabel.leftAnchor.constraint(equalTo: albumGenereContainer.leftAnchor , constant: 8).isActive = true
        albumGenereLabel.rightAnchor.constraint(equalTo: albumGenereContainer.rightAnchor , constant: -8).isActive = true
        albumGenereLabel.bottomAnchor.constraint(equalTo: albumGenereContainer.bottomAnchor, constant: -4).isActive = true
        
        view.addSubview(visitAlbumButton)
        visitAlbumButton.addTarget(self, action: #selector(visitAlbum), for: .touchUpInside)
        
        visitAlbumButton.translatesAutoresizingMaskIntoConstraints = false
        visitAlbumButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        visitAlbumButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        visitAlbumButton.widthAnchor.constraint(equalToConstant: 155).isActive = true
        visitAlbumButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        view.addSubview(copyRightTextLabel)
        copyRightTextLabel.text = "Copyright © 2022 Apple Inc. All rights reserved."
        
        copyRightTextLabel.translatesAutoresizingMaskIntoConstraints = false
        copyRightTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 16).isActive = true
        copyRightTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -16).isActive = true
        copyRightTextLabel.bottomAnchor.constraint(equalTo: visitAlbumButton.topAnchor, constant: -24).isActive = true
        
        view.addSubview(releaseTextLabel)
        
        releaseTextLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseTextLabel.leftAnchor.constraint(equalTo: view.leftAnchor , constant: 16).isActive = true
        releaseTextLabel.rightAnchor.constraint(equalTo: view.rightAnchor , constant: -16).isActive = true
        releaseTextLabel.bottomAnchor.constraint(equalTo: copyRightTextLabel.topAnchor).isActive = true
    }
    
    @objc func visitAlbum() {
        guard
            let model = viewModel.album,
            let albumUrl = URL(string: model.url)
        else { return }
        
        UIApplication.shared.open(albumUrl)
    }
}

extension AlbumDetailViewController: AlbumFeedDetailViewModelDelegate {
    func albumReceived(withError: NetworkError?) {
        if let withError = withError {
            print(withError.localizedDescription)
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.updateUI()
            }
        }
    }
}
