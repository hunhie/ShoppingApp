//
//  SearchView.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/08.
//

import UIKit

final class SearchView: BaseView {
  
  let searchBar = SearchBar()
  let filterView = ShopItemFilterView()
  let collectionView = ShopCollectionView()
  
  override func configureView() {
    
    addSubview(searchBar)
    addSubview(filterView)
    addSubview(collectionView)
    filterView.isHidden = true
  }
  
  override func setConstraints() {
    
    searchBar.snp.makeConstraints { [weak self] make in
      guard let self else { return }
      make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(5)
      make.top.equalTo(self.safeAreaLayoutGuide).offset(-5)
    }
    
    filterView.snp.makeConstraints { [weak self] make in
      guard let self else { return }
      make.top.equalTo(searchBar.snp.bottom).offset(5)
      make.leading.equalTo(safeAreaLayoutGuide).offset(15)
      make.height.equalTo(45)
    }
    collectionView.snp.makeConstraints { [weak self] make in
      guard let self else { return }
      make.top.equalTo(filterView.snp.bottom)
      make.horizontalEdges.equalTo(safeAreaLayoutGuide)
      make.bottom.equalTo(safeAreaLayoutGuide)
    }
  }
}
