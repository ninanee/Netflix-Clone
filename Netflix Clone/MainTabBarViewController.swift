//
//  ViewController.swift
//  Netflix Clone
//
//  Created by Yun Ni on 2024-06-07.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemYellow
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadsViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "keyboard.fill")
        vc2.tabBarItem.image = UIImage(systemName: "personalhotspot.circle")
        vc3.tabBarItem.image = UIImage(systemName: "globe.americas")
        vc4.tabBarItem.image = UIImage(systemName: "bolt.heart.fill")

        vc1.title = "Home"
        vc2.title = "Coming Soon"
        vc3.title = "Top Search"
        vc4.title = "Downloads"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }


}

