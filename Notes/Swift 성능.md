# 배경
- 현재 Entity 를 정의할 때, class 를 사용
- Swift 개발자 가이드에는 아래와 같은 기준으로 선택하라고 되어 있음
  - Use structures when you're modeling data that contains information about an entity with an identity that you don't control.
  - If the consistency of an app's models is stored on a server, you can model records as structures with identifiers.
  - 참조 : https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes 


# 질문
- struct 로 정의하는 것과 class 로 정의하는 것의 차이가 있나?


# 성능에 영향을 주는 3요소

### 1. Allocation
  - 기본적으로 struct 는 stack 에, class 는 heap 에 저장
  - stack 은 구조가 단순해서, 접근이 빠름
  - heap 은 여러 Thread 가 동시에 접근이 가능하기에, 동시성에 대한 고려가 필요 (ex. Lock)
    - 때문에, stack 보다 성능이 느림

      
### 2. Reference Counting
  - ARC 란?
    - https://github.com/taitty/SwiftPractice/blob/master/Notes/ARC.md
  - class 는 heap 에 저장되므로, Reference Count 가 증가하고, Instance 내부에 RC Value 를 갖고 있음
  - Reference Count 의 증가/감소 동작이 Thread-Safe 를 보장해야 하므로, 이에 대한 Over-Head 가 발생함
  
> struct 내부에 class 을 property 로 갖거나, String 을 갖는다면?

    - String 이나 Array 도 class 와 마찬가지로 heap 에 저장됨
    - 때문에, stack 에서 heap 영역을 참조하는 상황이 발생
    - 이런 property 가 여러 개 존재할 경우, class 보다 더 많은 Over-Head 가 발생함
    - 가능하다면, stack 에 저장될 수 있도록 String 대신, 다른 struct 혹은 enum 을 선언해서 사용해야 함
      
> struct 내부에 String 등의 Reference Type 의 Property 가 존재한다면, class 를 사용해야 하나?

    - copy-on-write 기능에 의해, 단순 복사의 경우에는 stack 내에 heap 위치 참조를 위한 변수만 할당
    - 실제 heap 내에 신규 영역 할당은, 복사된 변수에 값을 변경하는 경우에 발생
    - 때문에, data 변경이 발생하지 않는다면, struct 를 사용하는 것이 빠름
    
      
### 3. Method Dispatch
  - Compiler 시점에 호출될 Method 를 알 수 있고, 해당 반환값을 알 수 있다면, 최적화 기능을 통해 값을 바로 반환하도록 대체됨 (Inlining)
  - 이를 Static Dispatch 라고 함
  - 반대로, Compile Time 에 알 수 없는 경우, Run Time 시에 해당 구현 지점으로 JUMP 하게 되는데, 이를 Dynamic Dispatch 라고 함
    - ex) 다형성을 이용한 Factory Pattern, Template Pattern 적용 등...
  - 이 경우, Compiler 에 의한 최적화를 방해하기 때문에, Run Time 시의 수행 시간이 증가할 수 있음
  - class 는 Method 를 기본적으로 Dynamic Dispatch 함

        작성 시, final keyword 를 사용한다면, Compiler 가 Static Dispatch 를 수행할 수 있음
        
### 읽어볼 만한 내용
- https://velog.io/@yohanblessyou/Struct와-Class-중-무엇을-쓸까
