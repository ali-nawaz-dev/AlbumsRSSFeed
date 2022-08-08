//
//  AlbumFeedCollectionViewCell.swift
//  AlbumsRSSFeed
//
//  Created by Sheikh Ali on 06/08/2022.
//

import UIKit

class AlbumFeedCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AlbumFeedCollectionViewCell"
    
    var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var coverFadeView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    var albumNameLabel: UILabel = {
        let albumLabel = UILabel()
        albumLabel.textColor = .white
        albumLabel.textAlignment = .left
        albumLabel.numberOfLines = 3
        albumLabel.font = .body1
        return albumLabel
    }()
    
    var artistNameLabel: UILabel = {
        let artistLabel = UILabel()
        artistLabel.textColor = .gray
        artistLabel.textAlignment = .left
        artistLabel.numberOfLines = 3
        artistLabel.font = .caption
        return artistLabel
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        coverFadeView.applyGradient(isVertical: true, colorArray: [.black.withAlphaComponent(0.25), .black75])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
        artistNameLabel.text = nil
        albumNameLabel.text = nil
    }
    
    fileprivate func commonInit() {
        
        contentView.addSubview(coverImageView)
       
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(coverFadeView)
        contentView.bringSubviewToFront(coverFadeView)
       
        coverFadeView.translatesAutoresizingMaskIntoConstraints = false
        coverFadeView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        coverFadeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        coverFadeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        coverFadeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(artistNameLabel)
        contentView.bringSubviewToFront(artistNameLabel)
      
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        artistNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        artistNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12).isActive = true
        
        contentView.addSubview(albumNameLabel)
        contentView.bringSubviewToFront(albumNameLabel)
        
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        albumNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12).isActive = true
        albumNameLabel.bottomAnchor.constraint(equalTo: artistNameLabel.topAnchor).isActive = true
    }
    
    func setupCell(model: AlbumFeedCollectionViewCellViewModel) {
        
        albumNameLabel.text = model.albumName
        artistNameLabel.text = model.artistName
        ImageDownloader.shared.getImage(imagePath: model.artwork) { [weak self] image in
            self?.coverImageView.image = image
        }
    }
}

