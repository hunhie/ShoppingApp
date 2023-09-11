//
//  NaverShoppingAPIManager.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/08.
//

import Foundation
import Alamofire

/// Naver Shop API Manager
///
/// **Property**
/// - shared: Singleton instance
/// - baseURL: API Endpoint URL
///
/// **Method**
/// - callRequest: get result of query
final class NaverShoppingAPIManager {
  
  static let shared = NaverShoppingAPIManager()
  private init() { }
  
  static let baseURL = "https://openapi.naver.com/v1/search/shop.json"
  
  func callRequest(query: String, start:Int, display: Int = 10, sort: SortType, completion: @escaping (NaverShopList?) -> ()) {
    let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let url = "\(NaverShoppingAPIManager.baseURL)?query=\(text)&start=\(start)&display=\(display)&sort=\(sort.stringValue)"
    let headers: HTTPHeaders = [
      "X-Naver-Client-Id": APIKey.Naver.clientID,
      "X-Naver-Client-Secret": APIKey.Naver.clientSecret
    ]
    
    AF.request(url, method: .get, headers: headers).validate(statusCode: 200...500).responseDecodable(of: NaverShopList.self) { response in
      switch response.result {
      case .success(let value):
        completion(value)
      case .failure(let error):
        print(error)
        completion(nil)
      }
    }
  }
  
  enum SortType: Int, CaseIterable {
    case sim, date, dsc, asc
    
    var stringValue: String {
      String(describing: self)
    }
  }
}


