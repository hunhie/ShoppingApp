//
//  BaseViewController.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/08.
//

import UIKit

class BaseViewController: UIViewController {
  
  override func viewDidLoad() {
      super.viewDidLoad()
      configureView()
      setConstraints()
  }
  
  func configureView() {
    view.backgroundColor = .systemBackground
  }
  
  func setConstraints() {}
}
