//
//  BaseCollectionViewCell.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/09.
//

import UIKit
import SnapKit

class BaseCollectionViewCell: UICollectionViewCell {
  
  override init(frame: CGRect) {
    super.init(frame: frame)

  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setConstraints() { }
  
  func configureView() { }
}
