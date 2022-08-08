//
//  FeedListCoordinator.swift
//  AlbumsRSSFeed
//
//  Created by Sheikh Ali on 09/08/2022.
//

import Foundation
import UIKit

final class FeedListCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let feedListViewController = AlbumsFeedViewController()
        feedListViewController.viewModel.coordinator = self
        navigationController.setViewControllers([feedListViewController], animated: true)
    }
    
    func startFeedDetail(albumId: String) {
        let feedDetailCoordinator = FeedDetailCoordinator(navigationController: navigationController)
        childCoordinators.append(feedDetailCoordinator)
        feedDetailCoordinator.parentCoordinator = self
        feedDetailCoordinator.albumId = albumId
        feedDetailCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
            navigationController.popViewController(animated: true)
        }
    }
}
