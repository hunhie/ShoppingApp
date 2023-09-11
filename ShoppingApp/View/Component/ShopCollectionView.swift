//
//  ShopCollectionView.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/09.
//

import UIKit

final class ShopCollectionView: BaseView {
  let collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func configureView() {
    super.configureView()
    
    addSubview(collectionView)
  }
  
  override func setConstraints() {
    super.setConstraints()
    
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  func setupCollectionViewLayout(screen: UIScreen?) {
    guard let screen else { return }
    let layout = UICollectionViewFlowLayout()
    let spacing: CGFloat = 15
    let width = screen.bounds.size.width - spacing * 3
    layout.itemSize = CGSize(width: width / 2, height: width/2 * 1.45)
    layout.minimumLineSpacing = spacing
    layout.minimumInteritemSpacing = spacing
    layout.scrollDirection = .vertical
    layout.sectionInset = UIEdgeInsets(top: 5, left: spacing, bottom: spacing, right: spacing)
    self.collectionView.collectionViewLayout = layout
  }
  
  func scrollToTop(animated: Bool) {
    collectionView.scrollToItem(at: IndexPath(item: -1, section: 0), at: .init(rawValue: 0), animated: animated)
  }
}
