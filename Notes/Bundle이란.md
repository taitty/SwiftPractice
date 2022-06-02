App 의 Code 나 Resource 파일들의 묶음
* 하나의 Project 에, 하위 프로젝트로 기능들이 나뉘어 있다면, Bundle 을 하위 Project 의 Identifier 로 설정해주어야 함.
  * ex) Storyboard 로부터 ViewController 를 가져올 때, "BrowseScreen" 이라는 Storyboard 가 하위 Project 내에 존재할 경우,

        let bundle = Bundle(identifier: "com.home.taitty")
        let storyboard = UIStoryboard(name: "BrowseScreen", bundle: bundle)
      
* 생성자 : https://developer.apple.com/documentation/foundation/bundle/1411929-init
  * nil 로 설정할 경우, Bundle.main 을 참조하게 됨
