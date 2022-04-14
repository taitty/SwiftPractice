# URLSession
- HTTP/HTTPS를 통해 Data 를 주고받는 API 를 제공하는 class


## URLSessionConfiguration
- shared
  - 간단한 request 구현 가능
  - configuration 은 미지원
- default
  - 기본적으로 생성할 때
- ephemeral
  - cache, cookie, credentials 등을 저장하지 않아서, session 이 종료되면 정보가 날아감
  - 임시적으로 사용할 때.
- background
  - background 에서 download 등의 동작을 수행할 때
  - 앱 종료 후에도 동작이 필요할 때


## URLSessionTask
- 하나의 Session 을 정의하기 위한 class
- URLSessionDataTask
  - GET으로 Download 한 Data 를 Memory 에 저장
- URLSessionUploadTask
  - POST, PUT 으로 Web Server 로 Data 을 전송
- URLSessionDownloadTask
  - 서버에서 데이터 or 파일을 다운로드 할 경우 사용

### State Control
- cancel() : Task 를 취소
- resume() : 일시중지 되어있던 Task 를 다시 시작
- suspend() : Task 를 일시중지
> URLSessionTask 인스턴스 생성 시 초기상태가 suspend()이므로, resume()으로 시작  

### 일시정지 후, 이어받기
- 일시정지
  - cancel(byProducingResumeData:) : `byProducingResumeData` 클로저에서 진행중인 data 를 얻고 이 data 를 기록
- 취소
  - cancel()
- 이어받기
  - 기존 데이터가 있을 경우 : `urlSession.downloadTask(withResumeData:)`
  - 없을 경우 (처음부터) : `urlSession.downloadTask(with:)`


## HTTPURLResponse
- allHeaderFields
  - [AnyHashable : Any]
  - All HTTP header fields of the response.
- statusCode
  - Int
  - The response’s HTTP status code.

