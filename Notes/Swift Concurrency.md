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
