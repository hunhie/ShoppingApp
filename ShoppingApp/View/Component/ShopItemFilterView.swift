//
//  ShopItemFilterView.swift
//  ShoppingApp
//
//  Created by walkerhilla on 2023/09/10.
//

import UIKit

final class ShopItemFilterView: BaseView {
  
  lazy var stackView: UIStackView = {
    let stackView = UIStackView()
    let titles = Strings.Search.filterButton.allCases
    let types = NaverShoppingAPIManager.SortType.allCases
    for i in 0...3 {
      let button = RoundButton()
      button.title = titles[i].rawValue
      button.type = types[i]
      button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
      stackView.addArrangedSubview(button)
    }
    stackView.axis = .horizontal
    stackView.spacing = 8
    stackView.alignment = .fill
    stackView.distribution = .fillProportionally
    return stackView
  }()
  
  weak var delegate: ShopItemFilterProtocol?
  
  var selectedButton: NaverShoppingAPIManager.SortType = .sim
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func configureView() {
    super.configureView()
    
    addSubview(stackView)
    setSelectedButtonStyle()
  }
  
  override func setConstraints() {
    super.setConstraints()
    
    stackView.snp.makeConstraints { make in
      make.height.equalTo(32)
      make.horizontalEdges.equalToSuperview()
    }
  }
  
  func setSelectedButtonStyle() {
    stackView.arrangedSubviews.forEach { view in
      guard let button = view as? RoundButton else { return }
      button.setButtonStyle(selectedType: selectedButton)
    }
  }
  
  @objc func buttonTapped(_ sender: RoundButton) {
    guard let type = sender.type else { return }
    selectedButton = type
    setSelectedButtonStyle()
    delegate?.didFiltered(filterType: type)
  }
}
