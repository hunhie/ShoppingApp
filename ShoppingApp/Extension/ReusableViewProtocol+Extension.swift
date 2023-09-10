//
//  ReusableProtocol+Extension.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/09.
//

import UIKit

protocol ReusableViewProtocol: AnyObject {
  static var identifier: String { get }
  
}

extension UIViewController: ReusableViewProtocol {
  public static var identifier: String {
    return String(describing: self)
  }
}

extension UIView: ReusableViewProtocol {
  public static var identifier: String {
    return String(describing: self)
  }
}
