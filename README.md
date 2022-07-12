# 🚀 배달앱 클론코딩
[2022.02.22 ~ 2022.06.23]
<br><br>

---
## 구현 컨셉
- 배달앱(배달의민족, 쿠팡이츠)의 앱만을 참고하여 직접구현한 앱입니다.
- 2월에 스토리보드로 최초 구현했으며, Snapkit, Rxswift와 MVVM패턴 등등 각종 기술을 배워가면서 리펙토링해나간 연습용 프로젝트입니다.
- 표시되는 모든 데이터는 가상UI가 아닌 모두 백엔드에서 관리하는 데이터들입니다.(유저, 매장, 찜, 리뷰, 메뉴 등등)
- 깃클론 후 집접 실행해서 확인해보세요 👉🏻 (id: chichu, pw: 1231)

---
## 개발 일지 노션 페이지
👉👉👉🏻 <a href="https://inquisitive-mandrill-30f.notion.site/update-ff11e1fa224143d0ad53bb9ca24d36f2">개발일지 (배달앱클론코딩 update사항 🔥)</a>

---
## Packages used

- <a href="https://github.com/ReactiveX/RxSwift" target="_blank">RxSwift</a>
- <a href="https://github.com/RxSwiftCommunity/RxGesture" target="_blank">RxGesture</a>
- <a href="https://github.com/RxSwiftCommunity/RxDataSources" target="_blank">RxDataSources</a>
- <a href="https://github.com/SnapKit/SnapKit" target="_blank">SnapKit</a>
- <a href="https://github.com/AliSoftware/Reusable" target="_blank">Reusable</a>

---
## Backend
- 사용 툴: Node.js(express.js),TypeScript, AWS
- 백엔드(Node.js)에서 다음과 같은 랜덤한 데이터를 만들어 줍니다.
  1. 200개의 랜덤타입의 매장을 만듭니다.
  2. 각각의 매장은 2-6개의 섹션, 각센션별로 2-7개의 메뉴를 가집니다.
  3. 각각의 매장은 4-10개의 리뷰를 가지며, 각각의 리뷰는 랜덤유저와 연결되어 저장됩니다.
- POST요청은 오직 회원가입과 로그인을 할때뿐입니다. 나머지는 모두 GET요청입니다. 
  <br>장바구니의 경우 swift의 `UserDefault`를 이용하여 구현했습니다.

---
# 📲 화면구성

<img src="https://kirkim.github.io/assets/storage/deliveryApp/set1.png" style="width:600px">

<img src="https://kirkim.github.io/assets/storage/deliveryApp/set2.png" style="width:600px">

<img src="https://kirkim.github.io/assets/storage/deliveryApp/set3.png" style="width:600px">

<img src="https://kirkim.github.io/assets/storage/deliveryApp/set4.png" style="width:600px">

<img src="https://kirkim.github.io/assets/storage/deliveryApp/set5.png" style="width:600px">
