//
//  FeedDetailCoordinator.swift
//  AlbumsRSSFeed
//
//  Created by Sheikh Ali on 09/08/2022.
//

import Foundation
import UIKit

final class FeedDetailCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    var parentCoordinator: FeedListCoordinator?
    var albumId: String?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let detailVC = AlbumDetailViewController(primarykey: albumId ?? "")
        detailVC.viewModel.coordinator = self
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func didFinishFeedDetail() {
        parentCoordinator?.childDidFinish(self)
    }
}
