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
###1. Allocation
  - 기본적으로 struct 는 stack 에, class 는 heap 에 저장
  - stack 은 구조가 단순해서, 접근이 빠름
  - heap 은 여러 Thread 가 동시에 접근이 가능하기에, 동시성에 대한 고려가 필요 (ex. Lock)
    - 때문에, stack 보다 성능이 느림
  - 단, struct 내부에 class 을 property 로 갖거나, String 을 갖는다면?
    - String 이나 Array 도 class 와 마찬가지로 heap 에 저장됨
    - 때문에, stack 에서 heap 영역을 참조하는 상황이 발생
    - 이런 property 가 여러 개 존재할 경우, class 보다 더 많은 Over-Head 가 발생함
      -> 가능하다면, stack 에 저장될 수 있도록 String 대신, 다른 struct 혹은 enum 을 선언해서 사용해야 함
      
2. Reference Counting

3. Method Dispatch

# Allocation




# Reference Counting




# Method Dispatch


