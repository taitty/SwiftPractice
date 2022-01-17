### test code

  
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



