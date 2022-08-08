//
//  AppCoordinator.swift
//  AlbumsRSSFeed
//
//  Created by Sheikh Ali on 09/08/2022.
//

import Foundation

import UIKit

protocol Coordinator: AnyObject{
    var childCoordinators: [Coordinator]  { get }
    func start()
}

final class AppCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController.init()
        
        let feedListCoordinator = FeedListCoordinator(navigationController: navigationController)
        feedListCoordinator.start()
        
        childCoordinators.append(feedListCoordinator)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
