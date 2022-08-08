//
//  AlbumFeedViewModel.swift
//  AlbumsRSSFeed
//
//  Created by Sheikh Ali on 08/08/2022.
//

import Foundation

protocol AlbumFeedDetailViewModelDelegate {
    func albumReceived(withError: NetworkError?)
}

class AlbumFeedDetailViewModel {
    
    private let repository = AlbumFeedRepository()
    private var primaryKey: String
    
    var album: AlbumFeedModel?
    var delegate: AlbumFeedDetailViewModelDelegate? =  nil
    var coordinator: FeedDetailCoordinator?
    
    func viewDidDisappear(){
        coordinator?.didFinishFeedDetail()
    }

    init(primaryKey: String) {
        self.primaryKey = primaryKey
    }
    
    func getAlbumDetail() {
        repository.getAlbum(primaryKeyValue: primaryKey) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let album):
                self.album = album
                self.delegate?.albumReceived(withError: nil)
            case .failure(let error):
                self.delegate?.albumReceived(withError: error)
            }
        }
    }
}
