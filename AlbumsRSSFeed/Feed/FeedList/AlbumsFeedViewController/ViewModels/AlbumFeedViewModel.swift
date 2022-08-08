//
//  AlbumFeedViewModel.swift
//  AlbumsRSSFeed
//
//  Created by Sheikh Ali on 08/08/2022.
//

import Foundation
import RealmSwift

protocol AlbumFeedViewModelDelegate {
    func feedReceived(withError: NetworkError?)
}

class AlbumFeedViewModel {
    
    private let repository = AlbumFeedRepository()
    
    var models: [AlbumFeedCollectionViewCellViewModel] = []
    var delegate: AlbumFeedViewModelDelegate? = nil
    var coordinator: FeedListCoordinator?
    
    func fetchAlbums() {
        repository.getAlbums(refresh: false) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let albums):
                self.models = albums.map({
                    return AlbumFeedCollectionViewCellViewModel(
                        primaryKey: $0.id,
                        albumName: $0.name,
                        artistName: $0.artistName,
                        artwork: $0.artworkUrl100)
                })
                self.delegate?.feedReceived(withError: nil)
            case .failure(let error):
                self.delegate?.feedReceived(withError: error)
            }
        }
    }
    
    func showAlbumDetail(primaryKey: String) {
        coordinator?.startFeedDetail(albumId: primaryKey)
    }
}
