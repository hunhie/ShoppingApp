//
//  UIVIewController+Extension.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/09.
//

import UIKit

extension UIViewController {
  
  func screen() -> UIScreen? {
    var parent = self.parent
    var lastParent = parent
    
    while parent != nil {
      lastParent = parent
      parent = parent!.parent
    }
    
    return lastParent?.view.window?.windowScene?.screen
  }
  
  //  func addTapGestureForEndEditing() {
  //    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScreen))
  //    tapGestureRecognizer.cancelsTouchesInView = false
  //    view.addGestureRecognizer(tapGestureRecognizer)
  //  }
  //
  //  @objc func didTapScreen() {
  //    view.endEditing(true)
  //  }
}

extension UIViewController: UIScrollViewDelegate {
  public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    view.endEditing(true)
  }
}
