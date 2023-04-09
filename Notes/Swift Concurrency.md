# Concurrent vs Parallel
- 사전적 의미
  - Concurrent / Concurrency : 동시적 / 동시성
  - Parallel / Parallelism : 병렬적 / 병렬성
- Concurrent Programming
  - 가능한 많은 Task 를 동시에 수행하는 것  
> 서버에서 가능한 많은 클라이언트의 요청을 처리할 수 있도록 하는 것  
> 동시에 처리할 수 있는 클라이언트 수는 늘어나지만, 하나의 클라이언트에 대한 응답속도를 줄이지는 못함
- Parallel Programming
  - 하나 Task 를 더 작은 하위 Task 로 분할해서 동시에 처리하는 것
> 1 부터 100 까지의 합을 구할 때,  
> 1 ~ 10, 11 ~ 20, ... 으로 세분화해서 실행


# GCD
- https://github.com/taitty/SwiftPractice/blob/master/Notes/GCD.md


# Swift Concurrency vs GCD

||GCD|Swift Concurrency|
|---|---|---|
|도입|Object-C 에서부터 사용|21년에 소개된 신규 Programming API|
|문법|중첩된 Completion Handler 로 인해, 구조가 복잡해짐|async/await Keyword 도입으로 가독성이 좋아짐|
|Error|Completion Handler 에 Error 와 Data 를 같이 보냄|throw 를 통해 전달|
|Data Race|Compiler Time 에 알 수 없음|Compiler 가 Error 로 알려줌|
|성능|Thread Explosion 으로 과도한 Context Switching 발생 및 Dead-Lock 발생 우려가 있음|await 로 중단 시, 동일 Thread 내의 다음 함수가 수행됨. 추가적인 Context Switching 이 발생하지 않음|
|우선순위역전|FIFO 구조이므로, 우선순위가 높아도 먼저 추가된 Task 가 먼저 실행됨|FIFO 구조가 아님. 우선순위가 높은 Task 가 먼저 수행됨|

- Ref : 
  - https://tech.devsisters.com/posts/crunchy-concurrency-swift/
  - https://engineering.linecorp.com/ko/blog/about-swift-concurrency
