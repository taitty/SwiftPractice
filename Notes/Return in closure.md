## callback func 을 중복으로 사용하는 경우, callback func 의 return 은 어디로 가나?

> 하고 싶은거

아래와 같이 callback closure 를 간소화해서 사용할 수 있다면...

    var description: String? {
      testA() { $0 ? "bus" : "taxi" }
    }
    
    func testA(callback: @escaping (Bool) -> String) {
      callback(true)
    }
    
    print(description) // bus 가 찍히나?

결과는,

testA() 의 return type 이 Void 이기 때문에, description 의 String Type 과 맞지않아 Error

callback 의 return value 는, testA() 내의 "callback(true)" 의 return value



> 추가

아래와 같이, callback 으로 정의된 func 내에서는 return type 이 없는 것이 이상적인 듯...
callback 

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



> 추가 테스트

만약...callback 의 return type 이 func 이라면...?

ex) https://devxoul.gitbooks.io/ios-with-swift-in-40-hours/content/Chapter-3/functions-and-closures.html


    func helloGenerator(message: String) -> (String, String) -> String {
      func hello(firstName: String, lastName: String) -> String {
        return lastName + firstName + message
      }
      return hello
    }

    let hello = helloGenerator(message: "님 안녕하세요!")
    hello("수열", "전")
    
간소화하면,


    func helloGenerator(message: String) -> (String, String) -> String {
      return { $1 + $0 + message }
    }
    
