# ARC 란?
- Swift 의 heap 메모리를 관리
  - stack 에 저장되는 struct, enum 등의 type (value type) 은 Reference Count 가 증가하지 않음
- Instance 에 대한 Reference Count 를 관리하고, 값이 0 이 되면 deinit 을 통해 메모리 해제
- Complie Time 에 필요한 곳에 retail (count 증가) /release (count 감소) 를 Compiler 가 자동으로 삽입


# GC(Java) 와의 차이점
||GC|RC|
|---|---|---|
|계산시점|Run Time|Complie Time|
|장점|RC 에 비해 해제될 확률이 높음|Run Time 에 추가적인 Resource 가 필요하지 않음|
|단점|Run Time 에 추적하기 때문에 추가 Resource 필요(성능저하)|순환참조 발생 시, 영구적으로 해제되지 않음|


# weak, unowned
- 강한 참조를 피하기 위해 사용
- weak : nil 이 될 수 있는 경우에 사용
- unowned : 절대 nil 이 될 가능성이 없다는 보장이 있을 때 
