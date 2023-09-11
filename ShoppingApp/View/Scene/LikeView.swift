//
//  LikeView.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/11.
//

import UIKit

final class LikeView: BaseView {
  
  let searchBar = SearchBar()
  let collectionView = ShopCollectionView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func configureView() {
    super.configureView()
    
    addSubview(searchBar)
    addSubview(collectionView)
  }
  
  override func setConstraints() {
    super.setConstraints()
    
    searchBar.snp.makeConstraints { [weak self] make in
      guard let self else { return }
      make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(5)
      make.top.equalTo(self.safeAreaLayoutGuide).offset(-5)
    }
    
    collectionView.snp.makeConstraints { [weak self] make in
      guard let self else { return }
      make.top.equalTo(searchBar.snp.bottom)
      make.horizontalEdges.equalTo(safeAreaLayoutGuide)
      make.bottom.equalTo(safeAreaLayoutGuide)
    }
  }
}
