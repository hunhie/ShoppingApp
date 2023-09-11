//
//  RoundButton.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/11.
//

import UIKit

final class RoundButton: UIButton {
  
  var title: String?
  var type: NaverShoppingAPIManager.SortType?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureView() {
    layer.cornerRadius = 8
    layer.borderColor = UIColor.black.cgColor
    layer.borderWidth = 1
    
    if #available(iOS 15.0, *) {
      var config = UIButton.Configuration.plain()
      config.titlePadding = 10
      config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
      configuration = config
    } else {
      contentEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
  }
  
  func setButtonStyle(selectedType: NaverShoppingAPIManager.SortType) {
    let textColor: UIColor = type == selectedType ? .white : .black
    let backgroundColor: UIColor = type == selectedType ? .black : .white

    let attributedTitle = NSAttributedString(string: self.title ?? "", attributes: [
      NSAttributedString.Key.foregroundColor: textColor,
      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)
    ])
    
    self.backgroundColor = backgroundColor
    setAttributedTitle(attributedTitle, for: .normal)
  }
}
