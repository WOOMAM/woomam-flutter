# 🐘 woomam-flutter 🦣

우아한맘모스(우아한코끼리) 앱 개발 담당 이승환(@seunghwanly)입니다. 개발 툴은 **Flutter**를 사용하여 개발을 진행할 예정입니다. 해당 앱은 간단하게 데모 애플리케이션 수준으로 개발될 예정입니다. 디자인은 **Figma**로 진행하여 후에 디자인을 입힐 예정입니다. 앱에서 구현할 기능은 크게 5가지로 구성하였습니다.

## Main Features
1. 회원가입 및 본인인증
2. 세탁소 실시간 현황 출력
3. 세탁기 예약하기, 5분 제한
4. 세탁기 실행 with 옵션
5. QR 본인인증 tool

## Expected Requirements
1. Firebase를 이용한 본인인증 및 회원가입과 로그인 진행, Firebase에 프로젝트 등록
2. Mobile Map SDK가 필요
3. `Bloc` 패턴을 사용하여 실시간 Stream 반영, Server에서 일정 주기로 데이터 전송이 필요
4. QR 코드 인증을 위한 로직이 필요, 촬영 → 서버 전송 → 올바른 response 값 확인
5. 그 외 http 통신, Server and Arduino

## Etc.
지금까지 구상해둔 것은 아래와 같습니다.

### Models
모델들은 앱 내에서 http 통신을 하거나 json과 함께 사용할 예정입니다. 크게는 User, Store, Washer 그리고 Arduino로 최대한 compact하게 유지할 것 입니다.
#### User
> 사용자는 본인인증을 위해 uid가 필요합니다. QR로 본인인증을 해야하므로 예약한 세탁기 앞에 도착했을 때 uid를 확인하므로써 세탁기가 열린 상태로 변하게 됩니다. `reservedWasher`에 해당 매장과 세탁기의 uid가 저장되어있기 때문에 사용자가 도착하고 QR인증을 합니다. 이때 서버에서는 `reservedWasher`안의 정보가 QR로 전달된 `washer`의 `uid`가 전달되므로 이를 비교해서 `response`값을 전달해줍니다.
``` dart
class User {
  String _uid;
  String id;
  String _pw;
  String name;
  String phoneNumber;
  Washer? reservedWasher;
}
```

#### Store
> 가게 안에는 세탁기의 갯수가 여러개일 수 있으므로 list 형식으로 세탁기의 존재를 파악합니다. 후에 사용되고 있는 세탁기의 경우 `washers`안에 `running`중인 세탁기의 갯수를 파악해서 계산해 알려줍니다. 또한 `location`을 같이 저장하게 되어서 지도에 표시하기 쉽게 클래스안에 attribute로 넣어줍니다.
```dart
class Store {
  String storeName;
  String _storeUID;
  Geolocation location;
  List<Washer> washers;
}
```

#### Washer
> `enum`을 사용하여 각 상태를 정의해두었습니다. 세탁기는 세탁기 현재 상태, 연결되는 아두이노 그리고 각 `uid`가 선언되어있습니다.
``` dart
enum WasherState {
  running,
  turnedOff
}
```

``` dart
class Washer {
  String _storeUID;
  String _washerUID;
  Arduino arduino;
  WasherState washerState;
}
```

#### Arduino
> `enum`을 사용하여 아두이노의 상태를 정의해두었습니다. 아두이노의 상태에 따라서 세탁기의 문이 2중 잠금이 됩니다. 아두이노도 마찬가지로 안에 각각의 `uid`가 선언되어 있습니다.
``` dart
enum ArduinoState {
  opened,
  closed
}
```

```dart
class Arduino {
  String _arduinoUID;
  String _washerUID;
  String _storeUID;
  ArduinoState arduinoState;
}
```
