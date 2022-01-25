LIB 작성 혹은 Interface 정의 시, build break 방지를 위해 default func 을 추가

> 일반적으로 아래와 같이 구현

    protocol DefaultFuncProtocol {
      func showText()
    }

    extension DefaultFuncProtocol {
      func showText() {
          print("this is protocol")
      }
    }
  
    class Message: DefaultFuncProtocol {
      func showText() {
          print("this is class")
      }
    }

    func showMessage(this: DefaultFuncProtocol) {
      this.showText()
    }
    
    var message = Message()
    showMessage(this: message)
    
    // this is class
  
  
> 만약, default func 을 extension 에서만 구현한다면?

    protocol DefaultFuncProtocol {} // func 선언을 하지 않음

    extension DefaultFuncProtocol { // extension 에서 default func 만 구현
        func showText() {
            print("this is protocol")
        }
    }
  
    class Message: DefaultFuncProtocol {
      func showText() {
          print("this is class")
      }
    }

    func showMessage(this: DefaultFuncProtocol) {
      this.showText()
    }
    
    var message = Message()
    showMessage(this: message)
    
    // this is protocol
    

### 편의상 protocol 에서의 선언을 생략한다면, class 내의 재정의된 func 가 불리지 않는 문제가 발생할 수 있음!!!
