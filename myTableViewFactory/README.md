# TableView Factory
* 여러 종류의 하위 Cell 을 효율적으로 추가/관리하기 위해, Factory Pattern 을 적용
* TableView 생성 시, 각 Cell 의 등록 및 구성을 해당 Cell Controller 에서 수행하도록 함
* 중첩된 TableView 구성 시, Sub TableView 의 높이 계산을 위해, Cell 의 높이는 각 Cell Controller 에서 정하도록 함


## 1. ScreenShot

<img width="273" alt="스크린샷 2022-01-09 오전 10 36 42" src="https://user-images.githubusercontent.com/30424849/148665840-a5761827-8fc6-46bb-804b-a0d565c9194e.png">


## 2. Reference
  > https://tech.busuu.com/dealing-with-different-kinds-of-cells-in-swift-part-1-of-3-18c6cd10a0b3
