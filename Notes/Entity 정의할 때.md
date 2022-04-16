# struct 로 정의
- class 로 정의할 경우, heap 에 저장
- reference count 및 thread-safe 동작으로 성능에 영향을 줌

      struct MyStruct {
          let key: String
          let value: Int
      }


# property 는 let 으로 추가
- var 로 추가할 경우, 외부에서 변경이 가능
- 불필요한(의도하지 않은) Data 의 변경이 발생할 Risk 가 있음

      let data = MyStruct(key: "test", value: 1)
      data.key = "change" // error 
      data.value = 2 // error


# 옵셔널은 사용자제
- 옵셔널을 사용할 경우, Error Handling 을 다른 모듈로 전가시키는 결과를 초래
  - 어딘가에서 default value 를 설정해주어야 함
  - 결국, 최종적으로 값을 사용하는 곳에서 모든 경우에 대한 예외처리를 해주어야 함
- Data 유무가 가변적인 경우를 제외하고는 명시적으로 정의해주는 것이 맞음

