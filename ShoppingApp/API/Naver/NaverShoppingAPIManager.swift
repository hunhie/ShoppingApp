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
  
  static let baseURL = "https://openapi.naver.com/v1/search/shop.json?query="
  
  func callRequest(query: String, completion: @escaping (NaverShopData?) -> ()) {
    let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let url = NaverShoppingAPIManager.baseURL + text
    let headers: HTTPHeaders = [
      "X-Naver-Client-Id": APIKey.Naver.clientID,
      "X-Naver-Client-Secret": APIKey.Naver.clientSecret
    ]
    
    AF.request(url, method: .get, headers: headers).validate(statusCode: 200...500).responseDecodable(of: NaverShopData.self) { response in
      switch response.result {
      case .success(let value):
        completion(value)
      case .failure(let error):
        print(error)
        completion(nil)
      }
    }
  }
}


