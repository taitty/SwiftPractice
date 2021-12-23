# TableView Factory
* 여러 종류의 하위 Cell 을 효율적으로 추가/관리하기 위해, Factory Pattern 을 적용
* TableView 생성 시, 각 Cell 의 등록 및 구성을 해당 Cell Controller 에서 수행하도록 함
* 중첩된 TableView 구성 시, Sub TableView 의 높이 계산을 위해, Cell 의 높이는 각 Cell Controller 에서 정하도록 함
### Reference
  > https://tech.busuu.com/dealing-with-different-kinds-of-cells-in-swift-part-1-of-3-18c6cd10a0b3
## 앞으로...
* TableView 의 각 Cell 선택 시의 동작을 해당 Cell Controller 에서 수행하도록 추가
* CollectionView 도 동일하게 사용할 수 있도로 개선
  * Generic Type 적용
  * Reference
    > https://tech.busuu.com/dealing-with-different-kinds-of-cells-in-swift-part-2-of-3-3fe73b0c50c6
