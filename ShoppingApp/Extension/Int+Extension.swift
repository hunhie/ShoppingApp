//
//  Int+Extension.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/10.
//

import Foundation

extension Int {
  
  var numberformat: String? {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    
    return formatter.string(from: NSNumber(value: self))
  }
}
