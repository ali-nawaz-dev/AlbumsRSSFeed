//
//  ViewController.swift
//  AlbumsRSSFeed
//
//  Created by Sheikh Ali on 06/08/2022.
//

import UIKit

class AlbumsFeedViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    let viewModel = AlbumFeedViewModel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    func bindUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Top 50 Albums"
        
        addCollectionView()
        viewModel.delegate = self
        viewModel.fetchAlbums()
    }
    
    private func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(AlbumFeedCollectionViewCell.self,
                                forCellWithReuseIdentifier: AlbumFeedCollectionViewCell.identifier)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
}

extension AlbumsFeedViewController: AlbumFeedViewModelDelegate {
    func feedReceived(withError: NetworkError?) {
        DispatchQueue.main.async { [weak self] in
            if let withError = withError {
                if self?.viewModel.models.isEmpty ?? false {
                    self?.showRetryAlert(error: withError)
                }
            } else {
                self?.collectionView.reloadData()
            }
        }
    }
    
    func showRetryAlert(error: NetworkError) {
        
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
       
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] action in
            self?.viewModel.fetchAlbums()
        }))
        
        present(alert, animated: true)
    }
}

extension AlbumsFeedViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumFeedCollectionViewCell.identifier, for: indexPath) as? AlbumFeedCollectionViewCell {
            cell.setupCell(model: viewModel.models[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.frame.size.width) / 2 - 30
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showAlbumDetail(primaryKey: viewModel.models[indexPath.row].primaryKey)
    }
}

