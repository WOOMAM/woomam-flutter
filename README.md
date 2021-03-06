# ๐ woomam-flutter ๐ฆฃ

์ฐ์ํ์ฝ๋ผ๋ฆฌ(์ฐ์ฝ) Flutter ์ฑ ๊ฐ๋ฐ ๋ด๋น ์ด์นํ(@seunghwanly)์๋๋ค. ๋ณธ ์ ํ๋ฆฌ์ผ์ด์์ ์์ฌ์ด ๋ณธ์ธ์ธ์ฆ์ผ๋ก ์ด์ฉํ๋ ๋น๋๋ฉด ์์ฝ ์ฝ์ธ๋นจ๋๋ฐฉ์ ์ํ ๋ฐ๋ชจ ์ ํ๋ฆฌ์ผ์ด์์๋๋ค.
<p align="center">
  <a href="#features">Features โฆ </a>
  <a href="#used">Used โฆ </a>
  <a href="#models">Models โฆ </a>
  <a href="#structure">Structure โฆ </a>
  <a href="#usage">Usage</a>
</p>

---

## Features
1. Firebase ์ฐ๋ ํ์๊ฐ์ ๋ฐ ๋ณธ์ธ์ธ์ฆ
2. ์ธํ์ ์ค์๊ฐ ํํฉ ์ถ๋ ฅ
3. ์ธํ๊ธฐ ์์ฝํ๊ธฐ, 5๋ถ ์ ํ
4. ์ธํ๊ธฐ ์คํ with ์ต์
5. QR ๋ณธ์ธ์ธ์ฆ tool
6. Google Map์ ํ์ฉํ ๋นจ๋๋ฐฉ ์กฐํ

---

## Used
์ด๋ฒ ํ๋ก์ ํธ์์๋ **BLoC** ํจํด์ ์ฌ์ฉํ์์ต๋๋ค. ํํ ์๋ ค์ง MVVM๊ณผ ๋น์ทํ ๊ตฌ์กฐ๋ก state ๋ณํ๊ฐ ๋ง๊ณ  ๊ทธ์ ๋ฐ๋ฅธ cost๊ฐ ๋์ ํจ์จ์ ์ผ๋ก ์ฌ์ฉํ๊ธฐ ์ํด BLoCํจํด์ ์ฑํํ์ต๋๋ค. Stream์ ํตํด ๋ฐ์ดํฐ๋ฅผ ๊ด๋ฆฌํ๊ณ  ์ฌ์ฉ์์๊ฒ ๋ง๋ UI๋ฅผ ๋ณด์ฌ์ค๋๋ค.

### BLoC pattern ์์
![Owler Structure@2x](https://user-images.githubusercontent.com/22142225/132606092-c3b3af86-1e0e-44d1-ab70-1320541c45ba.png)

---

## Models
Model์ ์ฑ ๋ด์์ json์ ์์ฝ๊ฒ ์ฌ์ฉํ๊ณ  ๋ฐ์ดํฐ ์ ๋ฌ ์ ํธ๋ฆฌํจ์ ์ํด ์ ์๋์์ต๋๋ค. ๊ทธ๋ฆฌ๊ณ  BLoC์ ์ฌ์ฉํ๊ธฐ ์ํ ์ฒซ ๋จ๊ณ์ด๊ณ  ๊ฐ์ฅ ์ค์ํ ๋ถ๋ถ ์ค ํ๋์๋๋ค.

๊ตฌ์ฑํ Model์ User, Store, WashingMachine ๊ทธ๋ฆฌ๊ณ  ํ์ํ enum ์๋๋ค.

*ํ์ฌ๋ User, Store ๊ทธ๋ฆฌ๊ณ  WashingMachine์ ๊ธฐ์ค์ผ๋ก BLoC์ด ๊ตฌ์ฑ๋์์ต๋๋ค.*

### User
์ฌ์ฉ์๋ QR์ฝ๋๋ก ๋ณธ์ธ์ธ์ฆ์ ์งํํ๋ ๋ฐ ์ด๋ User์ ๋ณด ์ผ๋ถ๊ฐ ์ธํ๊ธฐ ์ ๋ณด์ ํจ๊ป ์ ์ก๋ฉ๋๋ค.
``` dart
class User {
  final String userName; // entered by user
  final String phoneNumber; // firebase
  final String userUID; // QR CODE, firebase UID
  final int point; // user affordable point
}
```

### Store
์์น์ ๋ณด๋ฅผ ์ํด์ ์๋์ ๊ฒฝ๋๋ฅผ ์ ์ฅํ๊ณ  ์ถํ์ Google Place API ์ฌ์ฉ์ด ํ์ ๋๋ฉด Geolocation์ ํตํด์ ์ฅ์๊ฒ์์ด ๊ฐ๋ฅํฉ๋๋ค.
> Geolocation์ ์ฌ์ฉํ์ง ์๊ณ  ๋ณ๋๋ก Store์ ๋ฐ์ดํฐ๋ฅผ ๋ฃ์ด ๊ฒ์์ด ๊ฐ๋ฅํ๊ฒ ํ  ์ ๋ ์์
```dart
class Store {
  final String storeUID;
  final String storeName;
  final double latitude;
  final double longitude;
}
```

### WashingMachine
ํ๋ก๊ทธ๋๋จธ๋ก ์ธํ ์ค๋ฅ๋ฅผ ์ค์ด๊ณ ์ `enum` ์ ์ด์ฉํด์ ๋๋จธ์ง state์ ๋ํด์ ๊ตฌํํ์ต๋๋ค.
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
qrState, arduinoState ๊ทธ๋ฆฌ๊ณ  washingMachineState๋ฅผ ํ์ฉํด์ WashingMachine ํด๋์ค ๋ด ์ํ๋ณ method๋ฅผ ๊ตฌํํด๋์์ต๋๋ค. ๊ทธ๋ฆฌ๊ณ  dart๋ deep copy๊ฐ ๊ธฐ๋ณธ์ ์ผ๋ก ์ด๋ฃจ์ด์ง๊ธฐ ๋๋ฌธ์ ์ด๋ฅผ handleํด์ค method๋ ์ถ๊ฐํ์์ต๋๋ค.
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
โโโ bloc
โ   โโโ store
โ   โโโ user
โ   โโโ washing_machine
โ   โโโ bloc.dart (exports everything)
โโโ components
โ   โโโ control_panel
โ   โโโ screen
โ   โ   โโโ app.dart
โ   โ   โโโ route.dart
โ   โโโ components.dart (exports everything)
โโโ model
โ   โโโ enum.dart
...
โ   โโโ model.dart (exports everything)
โโโ repository
โ   โโโ end_point.dart
โ   โโโ repository.dart (exports everything)
โโโ main.dart
```

### Description of Project Structure
- bloc : Store, User ๊ทธ๋ฆฌ๊ณ  WashingMachine์ ๋ชจ๋  state๋ฅผ ๊ด๋ฆฌํ๊ณ  event์ Data Layer๋ฅผ ์ด์ด์ค๋๋ค.
- components/control_panel : ์ฌ์ฌ์ฉ๋๋ control_panel, app๋ด theme์ด๋ ๊ฐ์ข widget์ ๋ค๋ฃน๋๋ค.
- components/screen/app.dart : ์ฑ์ ๋ชจ๋  ํ๋ฉด์ wrapํ๊ณ  ์๋ ์ฌ์ฉ์๊ฐ ๋์ผ๋ก ํ์ธํ  ์ ์๋ widget๋ค์ root์๋๋ค.
- components/screen/route.dart : ์ฌ์ฉ์์ ์ ๋ณด์ ๋ฐ๋ผ์ ์ฑ์ ํ๋ฉด์ ๊ฒฐ์ ํด์ฃผ๋ ๊ณณ ์๋๋ค.
- model : ๋ชจ๋ธ๊ณผ enum์ ๊ด๋ฆฌํ๋ ๊ณณ ์๋๋ค.
- repository : ์๋ฒ์ ์ง์ ์ ์ผ๋ก ํต์ ํ๋ Data Layer๊ฐ ์กด์ฌํ๋ ๊ณณ, end_point.dart ๋ด์์ endpoint๊ด๋ จ ํจ์๋ฅผ ๋ง๋ค์ด์ getter๋ก API์ ๋ชจ๋  ๊ฒฝ๋ก๋ฅผ ๋ถ๋ฌ์ฌ ์ ์๋๋ก ํ์ต๋๋ค.

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

[Google Cloud Platform](https://console.cloud.google.com/) ์์ API key ๊ฐ์ ๋ฐ๊ธ ๋ฐ์์ผํฉ๋๋ค.
- Maps SDK for Android
- Maps SDK for iOS
- Maps Static API
์ 3๊ฐ์ง๊ฐ `Enable` ๋์ด์๋ ์ง ํ์ธํด์ฃผ์ธ์.

`.env` ํ์ผ์ ๋ง๋ค์ด์ ์๋ ๊ฒฝ๋ก์ ์ถ๊ฐํด์ฃผ์ธ์.
> `woomam/.env`

``` env
GOOGLE_API_KEY={{your API key}}
```
