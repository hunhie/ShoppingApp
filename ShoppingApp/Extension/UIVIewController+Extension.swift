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
}
