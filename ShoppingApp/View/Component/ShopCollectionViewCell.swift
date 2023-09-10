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
  
  var data: NaverShopItem?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func configureView() {
    super.configureView()

    setupThumbImageView()
    setupMallNameLabel()
    setupTitleLabel()
    setupPriceLabel()
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
  }
  
  func setupThumbImageView() {
    contentView.addSubview(thumbImageView)
    if let data {
      thumbImageView.kf.setImage(with: URL(string: data.image))
    }
  }
  
  func setupMallNameLabel() {
    contentView.addSubview(mallNameLabel)
    if let data {
      mallNameLabel.text = "[\(data.mallName)]"
    }
  }
  
  func setupTitleLabel() {
    contentView.addSubview(titleLabel)
    titleLabel.text = data?.title.htmlEscaped
  }
  
  func setupPriceLabel() {
    contentView.addSubview(priceLabel)
    priceLabel.text = data?.price?.numberformat
  }
}
