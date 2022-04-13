# 요약
- UIKit 의 속성이 광대해서, 모든 기능을 Thread-safe 하게 설계하면 성능이 느려짐
- Thread-safe 하지 않게 설계한 것은 애플의 의도
- 때문에, Background Thread 가 UI 를 업데이트하면, View 가 제멋대로 동작할 수 있음
- 또한, 여러 Thread 에서 각자의 뷰의 변경사항 GPU 로 보낸다면, GPU는 각각의 정보를 다 해석해야하니 비효율적이고, 느려짐
- Texture 나 ComponentKit 과 같은 Facebook 에서 개발한 비동기적 UI Framework 가 있긴 하지만,
- 결국, View Drawing Cycle 이 유사한 방식으로 Main Thread 에서 업데이트 하도록 하고 있음


# 원본
> https://medium.com/@duwei199714/ios-why-the-ui-need-to-be-updated-on-main-thread-fd0fef070e7f


# 해석본
> https://drive.google.com/file/d/1dFw6sJsxV-huK3BoHXgDq-7rXy9yBq9l/view?usp=sharing
