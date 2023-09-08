//
//  MainTabBarController.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/08.
//

import UIKit

final class MainTapBarController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTabBar()
  }
  
  func setupTabBar() {
    
    tabBar.isTranslucent = false
    tabBar.tintColor = .white
    
    let shopping = UINavigationController(rootViewController: SearchViewController())
    let like = UINavigationController(rootViewController: LikeViewController())
    setViewControllers([shopping, like], animated: true)
    
    if let items = tabBar.items {
      items[0].image = UIImage(systemName: Strings.Search.tabBarItemImageName.rawValue)
      items[0].title = Strings.Search.tabBarItemTitle.rawValue
      
      items[1].selectedImage = UIImage(systemName: Strings.Like.tabBarItemSelectedImageName.rawValue)
      items[1].image = UIImage(systemName: Strings.Like.tabBarItemImageName.rawValue)
      items[1].title = Strings.Like.tabBarItemTitle.rawValue
    }
  }
}
