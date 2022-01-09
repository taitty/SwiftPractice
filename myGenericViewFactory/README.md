# GenericView Factory
* 여러 종류의 하위 Cell 을 효율적으로 추가/관리하기 위해, Factory Pattern 을 적용
* TableView, CollectionView, StackView 도 하나의 TableViewCell 로 등록
* 각 Cell 의 등록 및 구성을 해당 Cell Controller 에서 수행하도록 함
* 각 Cell 의 높이는 해당 Cell Controller 에서 정하도록 함


## 1. ScreenShot

<img width="273" alt="스크린샷 2022-01-09 오전 10 30 16" src="https://user-images.githubusercontent.com/30424849/148665724-13a1d996-36d2-4d2b-be3a-8dfde3b4bdb2.png">


## 2. Reference
  > https://tech.busuu.com/dealing-with-different-kinds-of-cells-in-swift-part-3-of-3-80275e29513b
