# 🐘 woomam-flutter 🦣

우아한코끼리(우코) Flutter 앱 개발 담당 이승환(@seunghwanly)입니다. 본 애플리케이션은 손쉬운 본인인증으로 이용하는 비대면 예약 코인빨래방을 위한 데모 애플리케이션입니다.
<p align="center">
  <a href='#features'>Features ◦ </a>
  <a href='#used'>Used ◦ </a>
  <a href='#models'>Models ◦ </a>
  <a href='#structure'>Structure ◦ </a>
  <a href='#usage'>Usage</a>
</p>

---

## Features
1. Firebase 연동 회원가입 및 본인인증
2. 세탁소 실시간 현황 출력
3. 세탁기 예약하기, 5분 제한
4. 세탁기 실행 with 옵션
5. QR 본인인증 tool
6. Google Map을 활용한 빨래방 조회

---

## Used
이번 프로젝트에서는 **BLoC** 패턴을 사용하였습니다. 흔히 알려진 MVVM과 비슷한 구조로 state 변화가 많고 그에 따른 cost가 높아 효율적으로 사용하기 위해 BLoC패턴을 채택했습니다. Stream을 통해 데이터를 관리하고 사용자에게 맞는 UI를 보여줍니다.

### BLoC pattern 예시


---

## Models
Model은 앱 내에서 json을 손쉽게 사용하고 데이터 전달 시 편리함을 위해 제작되었습니다. 그리고 BLoC을 사용하기 위한 첫 단계이고 가장 중요한 부분 중 하나입니다.

구성한 Model은 User, Store, WashingMachine 그리고 필요한 enum 입니다.

*현재는 User, Store 그리고 WashingMachine을 기준으로 BLoC이 구성되있습니다.*

### User
사용자는 QR코드로 본인인증을 진행하는 데 이때 User정보 일부가 세탁기 정보와 함께 전송됩니다.
``` dart
class User {
  final String userName; // entered by user
  final String phoneNumber; // firebase
  final String userUID; // QR CODE, firebase UID
  final int point; // user affordable point
}
```

### Store
위치정보를 위해서 위도와 경도를 저장하고 추후에 Google Place API 사용이 확정되면 Geolocation을 통해서 장소검색이 가능합니다.
> Geolocation을 사용하지 않고 별도로 Store에 데이터를 넣어 검색이 가능하게 할 수 도 있음
```dart
class Store {
  final String storeUID;
  final String storeName;
  final double latitude;
  final double longitude;
}
```

### WashingMachine
프로그래머로 인한 오류를 줄이고자 `enum` 을 이용해서 나머지 state에 대해서 구현했습니다.
``` dart
/// real washing machine
enum WashingMachineState {
  turnedOnOpened, // just turned on, not doing anything
  // turnedOnClosed, // turned on and user has put laundry
  running, // working
  turnedOff, // dead
}
/// `solenoid` state
enum ArduinoState {
  opened,
  closed,
}
```
qrState, arduinoState 그리고 washingMachineState를 활용해서 WashingMachine 클래스 내 상태별 method를 구현해두었습니다. 그리고 dart는 deep copy가 기본적으로 이루어지기 때문에 이를 handle해줄 method도 추가하였습니다.
``` dart
class WashingMachine {
  final String storeUID;
  final String washingMachineUID;
  final String? phoneNumber;
  final DateTime? taskFrom;
  final DateTime? taskTo;
  final DateTime? bookedTime;
  final QRState qrState;
  final ArduinoState arduinoState;
  final WashingMachineRunningState? washingMachineState;
}
```

---

## Structure
``` bash
lib
├── bloc
│   └── store
│   └── user
│   └── washing_machine
│   └── bloc.dart (exports everything)
├── components
│   └── control_panel
│   └── screen
│   │   └── app.dart
│   │   └── route.dart
│   └── components.dart (exports everything)
├── model
│   └── enum.dart
...
│   └── model.dart (exports everything)
├── repository
│   └── end_point.dart
│   └── repository.dart (exports everything)
└── main.dart
```

### Description of Project Structure
- bloc : Store, User 그리고 WashingMachine의 모든 state를 관리하고 event와 Data Layer를 이어줍니다.
- components/control_panel : 재사용되는 control_panel, app내 theme이나 각종 widget을 다룹니다.
- components/screen/app.dart : 앱의 모든 화면을 wrap하고 있는 사용자가 눈으로 확인할 수 있는 widget들의 root입니다.
- components/screen/route.dart : 사용자의 정보에 따라서 앱의 화면을 결정해주는 곳 입니다.
- model : 모델과 enum을 관리하는 곳 입니다.
- repository : 서버와 직접적으로 통신하는 Data Layer가 존재하는 곳, end_point.dart 내에서 endpoint관련 함수를 만들어서 getter로 API의 모든 경로를 불러올 수 있도록 했습니다.

## Usage
For help getting started with Flutter, view the online [documentation](https://flutter.io/).

### :bulb: Running the app locally
1. Clone this repository.
```terminal
$ git clone https://github.com/WOOMAM/woomam-flutter.git
```
2. Change directory depending on what appliaction you want to run.
```terminal
$ cd woomam-flutter/woomam/
```
3. Get packages
```terminal
$ flutter packages get
```
4. Run the app
```terminal
$ flutter run
```

### :bulb: Add `.env` file to Root directory

[Google Cloud Platform](https://console.cloud.google.com/) 에서 API key 값을 발급 받아야합니다.
- Maps SDK for Android
- Maps SDK for iOS
- Maps Static API
위 3가지가 `Enable` 되어있는 지 확인해주세요.

`.env` 파일을 만들어서 아래 경로에 추가해주세요.
> `woomam/.env`

``` env
GOOGLE_API_KEY={{your API key}}
```