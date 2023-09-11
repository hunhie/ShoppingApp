//
//  ShopCollectionViewCell.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/09.
//

import UIKit
import Kingfisher

final class ShopCollectionViewCell: BaseCollectionViewCell {
  
  lazy var thumbImageView: UIImageView = {
    let view = UIImageView()
    view.layer.cornerRadius = 8
    view.clipsToBounds = true
    view.contentMode = .scaleAspectFill
    view.backgroundColor = .gray
    return view
  }()
  
  lazy var mallNameLabel: UILabel = {
    let view = UILabel()
    view.font = .systemFont(ofSize: 13)
    view.textColor = .gray
    return view
  }()
  
  lazy var titleLabel: UILabel = {
    let view = UILabel()
    view.font = .systemFont(ofSize: 15)
    view.numberOfLines = 2
    view.lineBreakMode = .byTruncatingTail
    view.textColor = .black
    return view
  }()
  
  lazy var priceLabel: UILabel = {
    let view = UILabel()
    view.font = .monospacedDigitSystemFont(ofSize: 18, weight: .bold)
    view.numberOfLines = 1
    view.adjustsFontSizeToFitWidth = true
    view.minimumScaleFactor = 0.5
    return view
  }()
  
  lazy var likeButton: UIButton = {
    let view = UIButton()
    view.backgroundColor = .white
    view.layer.cornerRadius = 16
    view.clipsToBounds = true
    view.tintColor = .black
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.masksToBounds = false
    view.layer.shadowOffset = CGSize(width: 0, height: 1)
    view.layer.shadowRadius = 1
    view.layer.shadowOpacity = 0.2
    return view
  }()
  
  var item: NaverShopItem?
  var indexPath: IndexPath?
  let repository: LikeTableRepository = LikeTableRepository()
  weak var delegate: LikeButtonDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
  }
  
  override func configureView() {
    super.configureView()
    
    setupThumbImageView()
    setupMallNameLabel()
    setupTitleLabel()
    setupPriceLabel()
    setupLikeButton()
  }
  
  override func setConstraints() {
    super.setConstraints()
    
    thumbImageView.snp.makeConstraints { make in
      make.top.horizontalEdges.equalToSuperview()
      make.height.equalTo(contentView).multipliedBy(0.65)
    }
    
    mallNameLabel.snp.makeConstraints { make in
      make.top.equalTo(thumbImageView.snp.bottom).offset(5)
      make.horizontalEdges.equalTo(contentView).inset(5)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(mallNameLabel.snp.bottom).offset(2)
      make.horizontalEdges.equalTo(contentView).inset(5)
    }
    
    priceLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(2)
      make.horizontalEdges.equalTo(contentView).inset(5)
      make.bottom.lessThanOrEqualTo(5)
    }
    
    likeButton.snp.makeConstraints { make in
      make.bottom.trailing.equalTo(thumbImageView).inset(6)
      make.size.equalTo(32)
    }
  }
  
  func setupThumbImageView() {
    contentView.addSubview(thumbImageView)
    if let item {
      thumbImageView.kf.setImage(with: URL(string: item.image))
    }
  }
  
  func setupMallNameLabel() {
    contentView.addSubview(mallNameLabel)
    if let item {
      mallNameLabel.text = "[\(item.mallName)]"
    }
  }
  
  func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.text = item?.title.htmlEscaped
  }
  
  func setupPriceLabel() {
    contentView.addSubview(priceLabel)
    priceLabel.text = item?.price?.numberformat?.won
  }
  
  func setupLikeButton() {
    contentView.addSubview(likeButton)
    let image = UIImage(systemName: "heart")
    likeButton.setImage(image, for: .normal)
    likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    if let indexPath {
      likeButton.tag = indexPath.item
    }
    likeButtonImageToggle { [weak self] data in
      guard let self else { return }
      let filterdData = self.repository.fetchFilter(productID: data.productID)
      if filterdData.isEmpty {
        self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
      } else {
        self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
      }
    }
  }
  
  func likeButtonImageToggle(completion: @escaping (LikeTable) -> ()) {
    guard let item else { return }
    let data = LikeTable.fromNaverShopItem(item)
    completion(data)
  }
  
  @objc func likeButtonTapped() {
    likeButtonImageToggle { [weak self] data in
      guard let self else { return }
      let filterdData = self.repository.fetchFilter(productID: data.productID)
      if filterdData.isEmpty {
        self.repository.create(item: data)
        self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
      } else {
        self.repository.delete(item: filterdData)
        self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
      }
    }
    delegate?.didTapped()
  }
}
