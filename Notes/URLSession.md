# URLSession
- HTTP/HTTPS를 통해 Data 를 주고받는 API 를 제공하는 class


# URLSessionTask
- 하나의 Session 을 정의하기 위한 class
- URLSessionDataTask
  - GET으로 Download 한 Data 를 Memory 에 바로 저장
- URLSessionUploadTask
  - POST, PUT 으로 Web Server 로 Data 을 전송
- URLSessionDownloadTask
  - 서버에서 데이터 or 파일을 다운로드 할 경우 사용

URLsession으로 다운로드나 resource관련한 작업들을 처리하는 모듈
cancel() 메소드: task를 중지
resume() 메소드: task가 일시중지되어 있던 경우, 다시 시작
suspend() 메소드: task를 일시중지 (인스턴스 생성시 초기값은 suspend 상태)

다운로드: URLSessionTask 인스턴스 생성 시 초기상태가 suspend()이므로, resume()으로 시작
다운로드: resume()
일시정지: cancel(byProducingResumeData:) `byProducingResumeData`클로저에서 진행중인 data를 얻고 이 data를 기록
취소: cancel()
재개: 기존에 저장해둔 데이터가 있을땐 `urlSession.downloadTask(withResumeData:)`, 없을땐 `urlSession.downloadTask(with:)`
