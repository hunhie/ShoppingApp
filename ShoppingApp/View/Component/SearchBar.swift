//
//  SearchBar.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/09.
//

import UIKit

final class SearchBar: UISearchBar {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureView() {
    layer.cornerRadius = 8
    searchBarStyle = .minimal
    setValue("취소", forKey: "cancelButtonText")
    tintColor = .black
  }
  
  func setPlaceholder(text: String) {
    placeholder = text
  }
}
