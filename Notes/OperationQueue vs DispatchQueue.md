> https://stackoverflow.com/questions/7078658/operation-queue-vs-dispatch-queue-for-ios-application
- OperationQueue internally uses Grand Central Dispatch and on iOS.
- OperationQueue gives you a lot more control over how your operations are executed.<br>
  You can define dependencies between individual operations for example, which isn't possible with plain GCD queues.<br>
  It is also possible to cancel operations that have been enqueued in an OperationQueue (as far as the operations support it).<br>
  When you enqueue a block in a GCD dispatch queue, it will definitely be executed at some point.
- To sum it up,<br>
  - OperationQueue can be more suitable for,<br>
    - long-running operations that may need to be cancelled<br>
    - or have complex dependencies.<br>
  - GCD dispatch queues are better for,<br>
    - short tasks that should have minimum performance and memory overhead.
  

> https://caution-dev.github.io/ios/2019/03/15/iOS-GCD-vs-Operation-Queue.html
- Operation Queue에서는 동시에 실행할 수 있는 Operation의 최대 수를 지정할 수 있습니다.
- Operation Queue에서는 Operation을 일시 중지, 다시 시작 및 취소를 할 수 있습니다.
- Operation Queue에서는 KVO를 사용할 수 있는 많은 프로퍼티들이 있습니다.<br>
  isCancelled, isAsynchronous, isExecuting, isFinished, isReady, dependencies, queuePriority, completionBlock
- GCD는 앞선 기능을 하지 못합니다. Operation Queue를 좀 더 쉽게 쓸 수 있도록 개발한 것으로 좀 더 오버헤드가 있지만 사용하기에 매우 간편합니다.
