# 배경
- OOP 에서 출발한 상속의 경우,
  - Reference Type 이므로 수행 속도가 느림
  - 참조를 위해, Down-Casting 이 필요
  - Multi-Thread 환경에서 의도하지 않은 Data 변경이 발생
- Swift 는 하나의 class 만 상속 가능
  - 때문에, 확장에 제한이 걸리고, 복잡도가 증가함


# 장점
- Extension 으로 Method 에 대한 초기 구현이 가능
  - 채택하는 쪽에서 추가 구현이 필요없음
- Protocol 에 정의된 API 만 노출되므로, 가볍고 보안성이 높아짐
- Value Type(struct, enum) 에서도 채택이 가능
- class 상속이 수직 구조라면, Protocol 채택은 수평 구조
  - 다중 채택을 통한 확장이 가능
- Generic 과 associated type 을 활용하여 유연하게 적용 가능


# 결국...
- Protocol 채택만으로 필요한 기능을 사용할 수 있도록 하는 것
