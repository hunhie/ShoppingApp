//
//  LikeTable.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/11.
//

import Foundation
import RealmSwift

final class LikeTable: Object {

  @Persisted(primaryKey: true) var productID: String
  @Persisted var title: String
  @Persisted var link: String
  @Persisted var image: String
  @Persisted var lprice: String
  @Persisted var mallName: String
  
  convenience init(productID: String, title: String, link: String, image: String, lprice: String, mallName: String) {
    self.init()
    self.productID = productID
    self.title = title
    self.link = link
    self.image = image
    self.lprice = lprice
    self.mallName = mallName
  }
}

extension LikeTable {
  static func fromNaverShopItem(_ naverItem: NaverShopItem) -> LikeTable {
    let favoriteItem = LikeTable()
    favoriteItem.productID = naverItem.productID
    favoriteItem.title = naverItem.title
    favoriteItem.link = naverItem.link
    favoriteItem.image = naverItem.image
    favoriteItem.lprice = naverItem.lprice
    favoriteItem.mallName = naverItem.mallName
    return favoriteItem
  }
}
