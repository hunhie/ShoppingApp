//
//  LikeTableRepository.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/11.
//

import Foundation
import RealmSwift

protocol LikeTableRepositoryType: AnyObject {
  func fetch() -> Results<LikeTable>?
  func fetchFilter(productID: String) -> Results<LikeTable>
  func fetchFilter(query: String) -> Results<LikeTable>
  func create(item: LikeTable)
  func delete(item: Results<LikeTable>)
}

final class LikeTableRepository: LikeTableRepositoryType {
  
  let realm = try! Realm()
  
  func performRealmWrite(_ operation: () throws -> Void) {
    do {
      try realm.write {
        try operation()
      }
    } catch {
      print(error)
    }
  }
  
  func fetch() -> Results<LikeTable>? {
    var results: Results<LikeTable>?
    performRealmWrite {
      results = realm.objects(LikeTable.self)
    }
    return results
  }
  
  func fetchFilter(productID: String) -> Results<LikeTable> {
    let result = realm.objects(LikeTable.self).where {
      $0.productID == productID
    }
    return result
  }
  
  func fetchFilter(query: String) -> Results<LikeTable> {
    let result = realm.objects(LikeTable.self).where {
      $0.title.contains(query)
    }
    return result
  }
  
  func create(item: LikeTable) {
    performRealmWrite {
      realm.add(item, update: .modified)
    }
  }
  
  func delete(item: Results<LikeTable>) {
    performRealmWrite {
      realm.delete(item)
    }
  }
}
