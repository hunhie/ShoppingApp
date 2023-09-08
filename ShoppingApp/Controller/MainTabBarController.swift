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
      items[0].image = UIImage(systemName: "magnifyingglass")
      items[0].title = "검색"
      
      items[1].selectedImage = UIImage(systemName: "heart.fill")
      items[1].image = UIImage(systemName: "heart")
      items[1].title = "좋아요"
    }
  }
}
