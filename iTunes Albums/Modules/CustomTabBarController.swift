//
//  CustomTabBarController.swift
//  iTunes Albums
//
//  Created by Андрей Останин on 27.12.2020.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    
    // MARK: - VC lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupControllers()
        setupStyle()
    }
    
    // MARK: - UI setup
    private func setupStyle() {
        tabBar.tintColor = .red
        tabBar.alpha = 1
    }
    
    private func setupControllers() {
        let searchNavController = generateNavigationController(root: SearchViewController(),
                                                               title: K.TabBar.mainTabName,
                                                               image: UIImage(named: K.Image.search))
        
        let loadingsNavController = generateNavigationController(root: HistoryViewController(),
                                                                 title: K.TabBar.historyTabName,
                                                                 image: UIImage(named: K.Image.history))
        
        viewControllers = [searchNavController, loadingsNavController]
    }
    
    private func generateNavigationController(root: UIViewController, title: String, image: UIImage?) -> UINavigationController{
        root.navigationItem.title = title
        let navController = UINavigationController(rootViewController: root)
        navController.title = title
        navController.tabBarItem.image = image
        
        navController.navigationBar.isTranslucent = true
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.tintColor = .red
        
        return navController
    }
    
}
