//
//  DetailViewController.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/11.
//

import UIKit
import WebKit

final class DetailViewController: BaseViewController {
  
  let webView = WKWebView()
  var data: NaverShopItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(likeButtonTapped))
    navigationItem.rightBarButtonItem?.tintColor = .white
    
    guard let data else { return }
    title = data.title.htmlEscaped
    let url = URL(string: "https://msearch.shopping.naver.com/product/\(data.productID)")
    let request = URLRequest(url: url!)
    webView.load(request)
  }
  
  override func configureView() {
    super.configureView()
    view.addSubview(webView)
  }
  
  override func setConstraints() {
    super.setConstraints()
    
    webView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  @objc func likeButtonTapped() {
    
  }
}
