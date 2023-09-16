//
//  LikeViewController.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/08.
//

import UIKit
import RealmSwift

final class LikeViewController: BaseViewController {
  
  let mainView = LikeView()
  lazy var noResultsLabel: UILabel = {
    let view = UILabel()
    view.text = "좋아요 항목이 없습니다."
    return view
  }()
  
  var favoriteData: Results<LikeTable>?
  let repository = LikeTableRepository()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    fetchData { [weak self] data in
      guard let self,
      let data else { return }
      if data.isEmpty {
        self.noResultsLabel.isHidden = false
      } else {
        self.noResultsLabel.isHidden = true
        self.favoriteData = data
      }
      self.mainView.collectionView.collectionView.reloadData()
    }
  }
  
  override func loadView() {
    self.view = mainView
  }
  
  override func configureView() {
    super.configureView()
    
    setSearchBar()
    setTitle()
    setCollectionView()
    setCollectionViewCell()
    setNoResultLabel()
  }
  
  override func setConstraints() {
    super.setConstraints()
    
    noResultsLabel.snp.makeConstraints { make in
      make.centerX.centerY.equalToSuperview()
    }
  }
  
  private func setNoResultLabel() {
    view.addSubview(noResultsLabel)
  }
  
  private func setSearchBar() {
    mainView.searchBar.delegate = self
  }
  
  private func setTitle() {
    title = Strings.Like.navigationtitle.rawValue
  }
  
  private func setCollectionView() {
    mainView.collectionView.collectionView.delegate = self
    mainView.collectionView.collectionView.dataSource = self
    mainView.collectionView.setupCollectionViewLayout(screen: screen())
  }
  
  private func setCollectionViewCell() {
    mainView.collectionView.collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: ShopCollectionViewCell.identifier)
  }
  
  
  private func fetchData(completion: @escaping (Results<LikeTable>?) -> ()) {
    guard let data = repository.fetch() else { return completion(nil) }
    completion(data)
  }
  
  private func fetchFilteredData(completion: @escaping (Results<LikeTable>?) -> ()) {
    guard let query = self.mainView.searchBar.text,
          !query.isEmpty else { return completion(nil) }
    let data = repository.fetchFilter(query: query)
    completion(data)
  }
}

//MARK: - SearchBar Delegate Extension

extension LikeViewController: UISearchBarDelegate {
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    self.mainView.searchBar.showsCancelButton = true
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.mainView.searchBar.showsCancelButton = false
    self.mainView.searchBar.resignFirstResponder()
    fetchData { [weak self] data in
      guard let self else { return }
      self.favoriteData = data
      self.mainView.collectionView.collectionView.reloadData()
    }
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    fetchFilteredData { [weak self] data in
      guard let self,
            let data else { return }
      if data.isEmpty {
        self.favoriteData = nil
        self.noResultsLabel.isHidden = false
      } else {
        self.mainView.collectionView.scrollToTop(animated: false)
        self.favoriteData = data
        self.noResultsLabel.isHidden = true
      }
      self.mainView.collectionView.collectionView.reloadData()
    }
    view.endEditing(true)
  }
}

extension LikeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    guard let favoriteData else { return 0 }
    return favoriteData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCollectionViewCell.identifier, for: indexPath) as? ShopCollectionViewCell,
          let favoriteData else { return UICollectionViewCell() }
    let data = favoriteData[indexPath.item]
    print(data)
    cell.item = NaverShopItem.fromLikeTable(data)
    cell.indexPath = indexPath
    cell.delegate = self
    cell.configureView()
    cell.setConstraints()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let favoriteData else { return }
    let data = favoriteData[indexPath.item]
    let vc = DetailViewController()
    vc.data = NaverShopItem.fromLikeTable(data)
    navigationController?.pushViewController(vc, animated: true)
  }
  
}

extension LikeViewController: LikeButtonDelegate {
  func didTapped() {
    mainView.collectionView.collectionView.reloadData()
    
    if let favoriteData,
       favoriteData.isEmpty {
      noResultsLabel.isHidden = false
    }
  }
}
