//
//  ShopItemFilterProtocol.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/11.
//

import Foundation

protocol ShopItemFilterProtocol: AnyObject {
  func didFiltered(filterType: NaverShoppingAPIManager.SortType)
}
