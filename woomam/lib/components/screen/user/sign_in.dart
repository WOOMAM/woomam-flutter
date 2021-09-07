import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:woomam/components/control_panel/control_panels.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:woomam/components/screen/app.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  var countryCode = '+82';
  late TextEditingController _phoneNumberController;
  late var _pinCode;

  /// handle firebase sign-in event
  _handleSignInButtonOnTapped(String number) async {
    final validatedNumber = addIntlCodeToPhoneNumber(number);

    /// check response
    if (validatedNumber.runtimeType == String) {
      log('accessed user : ' + validatedNumber);
      return await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: validatedNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            final response =
                await _firebaseAuth.signInWithCredential(credential);
            // TODO set user state
            if (response.user != null) {
              log('logged in ${response.user!.phoneNumber}');
            }
          },
          verificationFailed: (FirebaseAuthException e) {
            if (e.code == 'invalid-phone-number') {
              showCustomSnackbar(context: context, msg: '전화번호 형식이 올바르지 않아요');
            }
          },
          codeSent: (String verificationId, int? resendToken) {
            _handleCodeSentFromFirebase(verificationId, resendToken);
          },

          /// time out
          timeout: const Duration(seconds: 10),
          codeAutoRetrievalTimeout: (String verificationId) {
            showCustomSnackbar(context: context, msg: '요청이 만료됐어요 😭 다시 요청해주세요');
          });
    } else {
      return showCustomSnackbar(context: context, msg: '전화번호를 입력해주세요');
    }
  }

  _handleCodeSentFromFirebase(String verificationId, int? resendToken) {
    return showBarModalBottomSheet(
        context: context,
        builder: (_) => GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: ListView(
                padding: paddingHV(24, 32),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                children: [
                  /// description text
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: '문자로 6자리 코드가 전송됐어요', style: headlineTextStyle()),
                    TextSpan(
                        text: '\n\n승인코드와 함께 회원가입, 로그인 끝 🤩',
                        style: bodyTextStyle()),
                  ])),
                  blankBoxH(height: 30),

                  /// pin code
                  PinCodeTextField(
                    /// functions
                    appContext: context,
                    length: 6,
                    onChanged: (String value) =>
                        setState(() => _pinCode = value),

                    /// styles
                    textStyle: headlineTextStyle(color: Colors.white),
                    pinTheme: PinTheme.defaults(
                      borderRadius: BorderRadius.circular(12.0),
                      shape: PinCodeFieldShape.box,
                      inactiveColor: secondaryColor,
                      activeColor: primaryColor,
                      activeFillColor: primaryColor,
                      inactiveFillColor: secondaryColor,
                    ),
                    enableActiveFill: true,

                    keyboardType: TextInputType.number,
                  ),

                  blankBoxH(height: 50),

                  /// submit button
                  ElevatedButton(
                    onPressed: () async {
                      PhoneAuthCredential _phoneAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: _pinCode);

                      /// SignIn with the [_phoneAuthCredential]
                      final signedInUserCredential = await _firebaseAuth
                          .signInWithCredential(_phoneAuthCredential);

                      /// pop screen first
                      Navigator.pop(context);
                      if (signedInUserCredential.user != null) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const RootScreen())).then(
                            (value) => showCustomSnackbar(
                                context: context, msg: '로그인 성공 😎'));
                      } else {
                        showCustomSnackbar(context: context, msg: '로그인 실패 😭');
                      }
                    },
                    child: Text(
                      '확인',
                      style: headlineTextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: emphasizeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: paddingHV(8, 16),
                    ),
                  )
                ],
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: primaryColor,
        body: SafeArea(
          child: ListView(
            padding: paddingHV(24, 24),
            shrinkWrap: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            children: [
              blankBoxH(height: height * 0.2),

              /// name of the app
              Align(
                alignment: Alignment.centerRight,
                child: RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'W',
                          style: largeTitleTextStyle(color: textColor)),
                      TextSpan(
                          text: 'OO',
                          style: largeTitleTextStyle(color: Colors.white)),
                      TextSpan(
                          text: 'C',
                          style: largeTitleTextStyle(color: Colors.amber)),
                      TextSpan(
                          text: 'O',
                          style: largeTitleTextStyle(color: Colors.white)),
                      TextSpan(
                          text: '\n\n 나만의 빨래방을 이용해보자',
                          style: headlineTextStyle(color: shallowPrimaryColor))
                    ],
                  ),
                ),
              ),
              blankBoxH(height: height * 0.2),

              /// textfield
              IntlPhoneField(
                /// display only one country - KR
                initialCountryCode: 'KR',
                countries: const ['KR'],

                /// style
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                ),
                showDropdownIcon: false,
                decoration: InputDecoration(
                  hintText: '전화번호를 입력해주세요',
                  hintStyle: callOutTextStyle(color: textColor),
                  helperStyle: captionTextStyle(color: shallowPrimaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      FeatherIcons.x,
                      color: textColor,
                    ),
                    onPressed: () => _phoneNumberController.clear(),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                controller: _phoneNumberController,
                onCountryChanged: handleCountryCodeOnChanged,
              ),
              blankBoxH(height: height * 0.05),

              /// sign-in button
              ElevatedButton(
                onPressed: () =>
                    _handleSignInButtonOnTapped(_phoneNumberController.text),
                child: Text(
                  '로그인',
                  style: headlineTextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: textColor,
                  padding: paddingHV(16, 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  /// if fails, returns `false`
  addIntlCodeToPhoneNumber(String number) {
    const pattern = r'^([0-9]{3})+([0-9]{4})+([0-9]{4})$';
    final regex = RegExp(pattern);
    final result = regex.hasMatch(_phoneNumberController.text);
    if (result) {
      return countryCode + number;
    }
    return false;
  }

  /// country code can be changed
  void handleCountryCodeOnChanged(PhoneNumber phoneNumber) =>
      setState(() => phoneNumber.countryCode);
}
