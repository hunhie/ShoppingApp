//
//  SearchViewController.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/08.
//

import UIKit
import Kingfisher

final class SearchViewController: BaseViewController {
  
  //MARK: - View Property
  
  lazy var mainView = SearchView()
  lazy var noResultsLabel: UILabel = {
    let view = UILabel()
    view.text = "검색 결과가 없습니다."
    return view
  }()
  
  //MARK: - Data Property
  
  var naverShopData: [NaverShopItem] = []
  var startItem: Int = 1
  var displayCount: Int = 10
  var selectedFilterType: NaverShoppingAPIManager.SortType = .sim
  let repository = LikeTableRepository()
  var query: String?
  
  //MARK: - ViewController Lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    mainView.collectionView.collectionView.reloadData()
  }
  
  override func loadView() {
    self.view = mainView
  }
  
  override func configureView() {
    super.configureView()

    setSearchBar()
    setFilterDelegate()
    setTitle()
    setCollectionView()
    setCollectionViewCell()
    view.addSubview(noResultsLabel)
  }
  
  override func setConstraints() {
    super.setConstraints()
    
    noResultsLabel.snp.makeConstraints { make in
      make.centerX.centerY.equalToSuperview()
    }
  }
  
  //MARK: - UI
  
  private func setSearchBar() {
    mainView.searchBar.delegate = self
  }
  
  private func setFilterDelegate() {
    mainView.filterView.delegate = self
  }
  
  private func setTitle() {
    title = Strings.Search.navigationtitle.rawValue
  }
  
  private func setCollectionView() {
    mainView.collectionView.collectionView.delegate = self
    mainView.collectionView.collectionView.dataSource = self
    mainView.collectionView.collectionView.prefetchDataSource = self
    mainView.collectionView.setupCollectionViewLayout(screen: screen())
  }
  
  private func setCollectionViewCell() {
    mainView.collectionView.collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: ShopCollectionViewCell.identifier)
  }

  //MARK: - Network
  
  private func fetchData(completion: @escaping (NaverShopList) -> ()) {
    guard let query = query else { return }
    NaverShoppingAPIManager.shared.callRequest(query: query, start: startItem, display: displayCount, sort: self.selectedFilterType) { response in
      guard let response else { return }
      completion(response)
    }
  }
}

//MARK: - SearchBar Delegate Extension

extension SearchViewController: UISearchBarDelegate {
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    self.mainView.searchBar.showsCancelButton = true
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    self.mainView.searchBar.showsCancelButton = false
    self.mainView.searchBar.resignFirstResponder()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    query = searchBar.text
    fetchData { [weak self] data in
      guard let self else { return }
      if data.items.isEmpty {
        self.naverShopData.removeAll()
        self.mainView.filterView.isHidden = true
        self.noResultsLabel.isHidden = false
      } else {
        self.mainView.filterView.isHidden = false
        self.noResultsLabel.isHidden = true
        self.mainView.collectionView.scrollToTop(animated: true)
        self.naverShopData = data.items
      }
      self.mainView.collectionView.collectionView.reloadData()
    }
    view.endEditing(true)
  }
}

//MARK: - CollectionView Delegate, Datasource Extension

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return naverShopData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShopCollectionViewCell.identifier, for: indexPath) as? ShopCollectionViewCell else { return UICollectionViewCell() }
    let data = naverShopData[indexPath.item]
    cell.item = data
    cell.indexPath = indexPath
    cell.configureView()
    cell.setConstraints()
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let data = naverShopData[indexPath.item]
    let vc = DetailViewController()
    vc.data = data
    navigationController?.pushViewController(vc, animated: true)
  }
}

extension SearchViewController: UICollectionViewDataSourcePrefetching {
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    for indexPath in indexPaths {
      if naverShopData.count - 1 == indexPath.row {
        startItem += displayCount
        fetchData { data in
          self.naverShopData += data.items
          self.mainView.collectionView.collectionView.reloadData()
        }
      }
    }
  }
}

//MARK: - ShopItemFilterProtocol

extension SearchViewController: ShopItemFilterProtocol {
  func didFiltered(filterType: NaverShoppingAPIManager.SortType) {
    selectedFilterType = filterType
    startItem = 1
    fetchData { data in
      self.mainView.collectionView.scrollToTop(animated: true)
      self.naverShopData = data.items
      self.mainView.collectionView.collectionView.reloadData()
    }
  }
}
