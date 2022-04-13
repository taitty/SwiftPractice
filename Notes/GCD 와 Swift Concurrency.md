# GCD (Grand Central Dispatch)
- Multi-Core Processor 및 Symmetric Multiprocessing System 에서, Application 을 최적화 하기 위해 Apple 에서 개발한 기술
- Thread Pool 관리를 OS 에 맡기도록 하는 것이 기본 개념


# DispatchQueue
- GCD 를 구현한 Swift class
- OS 에서 관리하는 Queue 에 Block (closure) 단위로 Task 를 쉽게 등록 가능
-등록된 Task 는  OS 에서 Thread 생성/분배/삭제를 관리

### Options

  1. Serial / Concurrent  
      - Serial
        - 등록된 Task 들이 순차적으로 실행
      - Concurrent
        - 등록된 순서는 보장하지만, 이전 Task 의 종료를 기다리지 않고 다음 Task 를 동시에 진행  
        - 종료 시간은 Task 마다 다를 수 있음  

  2. main / global
      - main
        - Main Thread 에 할당
        - Serial Queue
      - global
        - Main 이 아닌, 다른 Thread
        - Concurrent Queue
        - QoS Option : 우선 순위를 정할 수 있는 추가 옵션이 있음 (기본: .default)

  3. sync / async
      - sync : 등록된 작업이 끝날 때까지 기다림
      - async : 등록만 시키고, 작업은 계속 진행


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
