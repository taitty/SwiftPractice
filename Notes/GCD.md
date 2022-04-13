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

- Serial Queue 의 async 와 Concurrent Queue 의 async  
  - Case1:

        let queue = DispatchQueue.global()
        queue.async { Task-A }
        queue.async { Task-B }
        Task-C

        > Task-A/B 의 완료 순서는 보장되지 않음  
        > Task-C 는 Task-A/B 와 상관없이 수행됨  

  - Case2:

        let queue = DispatchQueue(label: "serial")
        queue.async { Task-A }
        queue.async { Task-B }
        Task-C

        > Task-A 가 완료된 후에, Task-B 가 수행됨  
        > Task-C 는 Task-A/B 와 상관없이 수행됨
     
## DispatchWorkItem
- DispatchQueue 에 할당할 Task 를 정의할 수 있음
- QoS 를 설정하여, 우선순위 지정이 가능

## DispatchGroup
- 여러 Queue 에서 실행되는 Task 들을 하나의 그룹으로 묶을 수 있음
- 그룹에 포함된 Queue 의 모든 Task 완료 여부를 확인할 수 있음
- Group 의 모든 Task 들이 완료된 후에 어떤 작업을 수행하도록 추가 가능
  - enter/leave/wait : 동기
  - enter/leave/notify : 비동기
  - Param 으로 group 지정/notify : 비동기

