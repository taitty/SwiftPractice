## callback 함수를 중복으로 사용하는 경우, callback 함수의 return 은 어디로 가나?

> 하고 싶은거

    var description: String? {
      testA() { $0 ? "bus" : "taxi" }
    }
    
    func testA(callback: @escaping (Bool) -> String) {
      callback(true)
    }
    
    print(description) // bus??

> 테스트

    var description: String? {
      var ret: String?
      testA() { ret = $0 ? "bus" : "taxi" }
      return ret
    }

    func testA(callback: @escaping (Bool) -> Void) {
        testB() { result in
            if result {
                callback(true)
            } else {
                callback(false)
            }
        }
    }

    func testB(callback: @escaping (Bool) -> Void) {
        callback(true)
    }

    print(description)
