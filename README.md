# 🚀 배달앱
[2022.02.22 ~ 2022.06.23]
<br><br>

---
## 구현 컨셉
- 배달앱(배달의민족, 쿠팡이츠)의 앱을 참고하여 구현한 앱입니다.
- 2월에 스토리보드로 최초 구현했으며, Snapkit, Rxswift와 MVVM패턴 등등 각종 기술을 배워가면서 리펙토링해나간 연습용 프로젝트입니다.
- 표시되는 모든 데이터는 가상UI가 아닌 모두 백엔드에서 관리하는 상호작용하는 데이터들입니다.(유저, 매장, 찜, 리뷰, 메뉴 등등)
- 코드 컨벤션없이 단순히 Uikit을 공부를하며 코드를 우겨넣은 앱입니다. 이 앱에서는 보여줄 수 없지만, 개인적으로 코드컨벤션의 중요성은 그 누구보다 잘 알고 있고 그런것들을 배우기위해 노력을 하고 있습니다.
- 실행 아이디 👉🏻 (id: chichu, pw: 1231)

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

단순히 UI만 구현한 것이 아닌 내부기능(장바구니, 가게타입분류, 음식담기버튼 활성화조건, 리뷰목록에서 작성자클릭시 해당작성자리뷰목록창열기, 장바구니가게명클릭시 해당가게창열기 등등..) 디테일하게 구현하고자 노력했습니다.<br>
밑의 **2번째** 짤의 화면은 쿠팡x츠앱에서 부자연스럽게 동작하는 것 같아 자연스럽게 동작하도록 신경써서 만든부분입니다.

|1|2|3|4|
|:--:|:--:|:--:|:--:|
|<img src="https://kirkim.github.io/assets/storage/deliveryApp/delivery4.gif" style="width:200px">|<img src="https://kirkim.github.io/assets/storage/deliveryApp/delivery1.gif" style="width:200px">|<img src="https://kirkim.github.io/assets/storage/deliveryApp/delivery2.gif" style="width:200px">|<img src="https://kirkim.github.io/assets/storage/deliveryApp/delivery3.gif" style="width:200px">|

<br><br>

로그인화면과 회원가입화면입니다. (apple로그인, kakao로그인 기능을 추가할 예정입니다)
<img src="https://kirkim.github.io/assets/storage/deliveryApp/set1.png" style="width:600px">

<br><br>
내가 쓴 리뷰 페이지에서 매장이름을 클릭하면 해당매장의 페이지로 이동할 수 있습니다.

<img src="https://kirkim.github.io/assets/storage/deliveryApp/set2.png" style="width:600px">

<br><br>
클릭한 셀과 일치하는 슬롯으로 이동합니다. 위쪽의 탭바 혹은 가로방향 스크롤로 슬롯이동이 가능합니다.

<img src="https://kirkim.github.io/assets/storage/deliveryApp/set3.png" style="width:600px">

<br><br>
매장리뷰페이지에서 유저이름을 클릭하면 해당유저의 리뷰목록페이지로 이동할 수 있습니다.
<br>메뉴페이지에서는 각섹션별 조건(최소 2개이상, 최소 1개이상 등등..)을 모두 만족하면 장바구니에 추가할 수 있습니다.

<img src="https://kirkim.github.io/assets/storage/deliveryApp/set4.png" style="width:600px">

<br><br>
장바구니에 메뉴가 1개이상 있을 경우 장바구니 아이콘이 표시됩니다.
<br>기존 메뉴가 있는경우 다른매장의 메뉴는 담을 수 없으며, 담을 경우 확인용 Alert창이 나타나 기존메뉴를 없애고 담아줄 수 있습니다.
<br>장바구니페이지에서 메뉴의 갯수를 조정할 수 있습니다.

<img src="https://kirkim.github.io/assets/storage/deliveryApp/set5.png" style="width:600px">

<br><br>
아래의 지도앱은 M1맥의 시뮬레이터에서 제대로 실행되지 않는 이슈가 있어서 레퍼지토리를 분리하였습니다. 👉🏻 <a href="https://github.com/kirkim/PracticeKakaoMap">카카오맵레퍼지토리</a>
<br>(M1맥에서 xcode를 로제타로 실행하기로 하거나, 모바일로 직접실행하면 제대로 작동하지만 개발시간이 오래걸리기 때문에 가장 마지막에 합칠 예정입니다.)

<img src="https://kirkim.github.io/assets/storage/deliveryApp/set6.png" style="width:600px">
