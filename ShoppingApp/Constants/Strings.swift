//
//  Strings.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/08.
//

import Foundation

enum Strings {
  enum Search: String {
    case navigationtitle = "쇼핑 검색"
    case tabBarItemTitle = "검색"
    case tabBarItemImageName = "magnifyingglass"
    
    enum filterButton: String {
      case accuracy = "정확도"
      case recent = "날짜순"
      case priceLowToHigh = "가격높은순"
      case priceHighToLow = "가격낮은순"
    }
  }
}
