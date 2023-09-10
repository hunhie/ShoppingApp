//
//  NaverShopData.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/08.
//

import Foundation

// MARK: - NaverShopList
struct NaverShopList: Codable {
  let lastBuildDate: String
  let total, start, display: Int
  let items: [NaverShopItem]
}

// MARK: - NaverShopItem
struct NaverShopItem: Codable {
  let title: String
  let link: String
  let image: String
  let lprice, hprice, mallName, productID: String
  let productType, brand, maker: String
  let category1: String
  let category2: String
  let category3: String
  let category4: String
  
  var price: Int? {
    Int(lprice)
  }
  
  enum CodingKeys: String, CodingKey {
    case title, link, image, lprice, hprice, mallName
    case productID = "productId"
    case productType, brand, maker, category1, category2, category3, category4
  }
}
