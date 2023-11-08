# ShoppingApp | Toy Project
### 프로젝트 개요
- 인원: 1명
- 기간: 2023.09.08 - 2023.09.12

### 한 줄 소개
- 네이버 쇼핑 상품 데이터를 제공하고 즐겨찾기 기능을 제공하는 iOS 앱 서비스

### 앱 미리보기

### 개발 환경
- Deployment Target: 13.0

### 이런 기술을 사용했어요
`MVC`, `UIKit`, `Snapkit`, `Alamofire`, `Decodable`, `REST API`, `Realm`, `SPM`, `Kingfisher`

### 이런 기능들이 있어요
- 네이버 쇼핑 검색 기능
- 상품 즐겨찾기 기능
- 즐겨찾기 상품 검색 기능
- 상품 상세 정보 제공(웹뷰)

### 주요 성과
- `Repository Pattern` 도입:   
데이터 관리 로직을 추상화하고 DB 데이터 액세스의 단일 진입점을 제공하여 로직의 유지보수성과 확장성을 향상함
- 재사용되는 뷰 컴포넌트화:
프로젝트에 반복적으로 사용되는 뷰를 컴포넌트화하여 재사용성을 향상함.

### 트러블 슈팅
#### 1. 상품의 즐겨찾기 상태가 올바르게 적용되지 않는 문제
**문제 상황**: 상품을 즐겨찾기한 후 스크롤을 하거나 화면을 이동할 경우 셀의 좋아요 버튼 상태가 예기치 않게 적용되는 문제 발생
**원인 분석**: 공식문서를 확인해본 결과 CollectionView의 `dequeueReusableCell` 메서드로 셀을 Configure하는 경우 내부적으로 Cell 객체를 재사용하면서 이전 Cell의 상태가 초기화되지 않음
**해결**: Cell 객체가 재사용되는 시점에 실행되는 `prepareForReuse` 메서드를 통해서 Cell이 담는 상태나 데이터 값들을 초기화하여 해결함.
```Swift
  override func prepareForReuse() {
    super.prepareForReuse()
    
    self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
  }
```
