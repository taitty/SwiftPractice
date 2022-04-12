# 배경
- 현재 Entity 를 정의할 때, class 를 사용
- Swift 개발자 가이드에는 아래와 같은 기준으로 선택하라고 되어 있음
  - Use structures when you're modeling data that contains information about an entity with an identity that you don't control.
  - If the consistency of an app's models is stored on a server, you can model records as structures with identifiers.
  - 참조 : https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes 

# 질문
- struct 로 정의하는 것과 class 로 정의하는 것의 차이가 있나?
- data 를 복사하는 것과 참조하는 것에 성능 차이가 있나?

# 성능에 영향을 주는 3요소
1. Allocation
2. Reference Counting
3. Method Dispatch

# Allocation




# Reference Counting




# Method Dispatch


