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
  let repository = LikeTableRepository()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setBarButtonItem()
    setWebView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    fetchFilter { [weak self] bool in
      guard let self else { return }
      self.barButtonItemToggle(bool)
    }
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
  
  private func setBarButtonItem() {
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(likeButtonTapped))
  }
  
  private func setWebView() {
    guard let data else { return }
    
    title = data.title.htmlEscaped
    let url = URL(string: "https://msearch.shopping.naver.com/product/\(data.productID)")
    let request = URLRequest(url: url!)
    webView.load(request)
  }
  
  private func fetchFilter(completion: @escaping (Bool) -> Void) {
    guard let data else { return }
    let filterdData = self.repository.fetchFilter(productID: data.productID)
    if filterdData.isEmpty {
      completion(false)
    } else {
      completion(true)
    }
  }
  
  private func barButtonItemToggle(_ isFavorited: Bool) {
    if isFavorited {
      navigationItem.rightBarButtonItem?.tintColor = .red
    } else {
      navigationItem.rightBarButtonItem?.tintColor = .lightGray
    }
  }
  
  @objc func likeButtonTapped() {
    fetchFilter { [weak self] bool in
      guard let self,
            let data else { return }
      let filterdData = self.repository.fetchFilter(productID: data.productID)
      if bool {
        self.repository.delete(item: filterdData)
      } else {
        let data = LikeTable.fromNaverShopItem(data)
        self.repository.create(item: data)
      }
      self.barButtonItemToggle(!bool)
    }
  }
}
