//
//  MainTabBarController.swift
//  TaxScan
//
//  Created by Gadirli on 06.09.23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBars()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)

    }
    
    
    
    
    // MARK: Helpers
    
    private func configureBars(){
        
        tabBar.backgroundColor = .white
       
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: CategoriesViewController())
        
        vc1.tabBarItem.title = "Home"
        vc2.tabBarItem.title = "Search"
        vc3.tabBarItem.title = "Categories"
        
        vc1.tabBarItem.image = UIImage(systemName: "house")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "list.bullet.circle")
        
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        setViewControllers([vc1, vc2, vc3], animated: true)
        
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
    


}
