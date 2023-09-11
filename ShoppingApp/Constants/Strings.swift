//
//  Strings.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/09.
//

import Foundation

enum Strings {
  enum Search: String {
    case navigationtitle = "쇼핑 검색"
    case tabBarItemTitle = "검색"
    case tabBarItemImageName = "magnifyingglass"
    
    enum filterButton: String, CaseIterable {
      case sim = "정확도"
      case date = "날짜순"
      case dsc = "가격높은순"
      case asc = "가격낮은순"
    }
  }
  
  enum Like: String {
    case navigationtitle = "좋아요 목록"
    case tabBarItemTitle = "좋아요"
    case tabBarItemImageName = "heart"
  }
}
