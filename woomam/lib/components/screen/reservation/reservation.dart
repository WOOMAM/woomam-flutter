import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

/// bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woomam/bloc/bloc.dart';

/// components
import 'package:flutter_svg/svg.dart';
import './qr_code.dart';
import './running_washing_machine.dart';
import '../../components.dart';

final List<String> laundryType = ['표준', '소량/쾌속', '타월', '이불세탁', '삶음', '무세제통세척'];

class ReservationScreen extends StatefulWidget {
  final String userPhoneNumber;
  const ReservationScreen({Key? key, required this.userPhoneNumber})
      : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  /// variables
  late bool isEnabled;
  late String _selectedType;

  /// display timer
  late Timer _timer;
  var _time = 0;

  @override
  void initState() {
    super.initState();

    /// init variables
    isEnabled = true;
    _selectedType = '';

    /// add event to fetch data
    BlocProvider.of<WashingMachineBloc>(context).add(
        GetReservationInformationEvent(
            userPhoneNumber: widget.userPhoneNumber));

    /// tick timer
    _timer = Timer.periodic(
        const Duration(seconds: 1), (timer) => setState(() => _time += 1));
  }

  /// handle the MultiChoiceChip OnSelected
  void _handleLaundryTypeOnSelected(String typeName) => setState(() {
        if (isEnabled) _selectedType = typeName;
      });

  /// handle the Running OnPressed
  void _handleRunningButtonOnPressed() {
    setState(() => isEnabled = !isEnabled);

    /// navigate
    Navigator.push(
      context,

      /// using [PageRouteBuilder] removes the basic navigation animation
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const RunningWashingMachineScreen(),

        /// the [transitionDuration] only handles
        /// the timeLength between `currentPage` to `nextPage`
        transitionDuration: const Duration(milliseconds: 800),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            Align(
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        ),
        reverseTransitionDuration: const Duration(milliseconds: 800),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // log(_timer.tick.toString(), name: 'reservation');

    /// how to use `Expanded` inside the `scrollable` widget
    ///
    /// use [LayoutBuilder] with [ConstrainedBox]
    return BlocBuilder<WashingMachineBloc, WashingMachineState>(
        builder: (context, state) {
      if (state is WashingMachineEmpty) {
        return emptyWidget;
      } else if (state is WashingMachineLoading) {
        return loadingWidget;
      } else if (state is WashingMachineError) {
        log('error \n' + state.msg, name: 'Reservation');
        return errorWidget;
      } else if (state is WashingMachineLoaded) {
        final reservedWashingMachine = state.reservedWashingMachine;

        if (reservedWashingMachine == null ||
            !reservedWashingMachine.isWashingMachineReserved(DateTime.now())) {
          return Padding(
            padding: paddingHV(24, 24),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: '예약하신 내역이 없어요 😭\n\n\n',
                      style: bodyTextStyle(color: shallowPrimaryColor)),
                  TextSpan(
                      text: '<예약하는 방법>\n\n',
                      style: headlineTextStyle(color: Colors.white)),
                  TextSpan(
                      text:
                          "'왼쪽에서 오른쪽 쓸기'\n>\n'지도 탭으로 가기'\n>\n'세탁기 아이콘 터치'\n>\n'세탁기 오른쪽 신청버튼 터치'",
                      style: callOutTextStyle(color: shallowPrimaryColor)),
                ]),
              ),
            ),
          );
        }

        /// the user has reserved washing machine
        else {
          /// calculate time in minutes
          var tickedLeftTimeInSeconds = reservedWashingMachine.getLeftDuration(DateTime.now()).abs().inSeconds;
          log('${reservedWashingMachine.bookedTime!.toLocal().toString()} vs. ${DateTime.now()}',
              name: 'LEFT TIME');
          log(reservedWashingMachine.getLeftDuration(DateTime.now()).abs().toString(),
              name: 'LEFT TIME');
          var leftMinutes = tickedLeftTimeInSeconds ~/ 60;
          var leftSeconds = tickedLeftTimeInSeconds - (leftMinutes * 60);

          /// build here
          /// check the reserveration

          return LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: constraints.maxHeight),
                child: Column(
                  children: [
                    blankBoxH(height: 50), // like app bar height

                    /// the reserved washing machine detail
                    /// show Title text and some descriptions for Washing Machine
                    bottomRightRoundedBox(
                      /// size
                      height: height * 0.3,
                      width: width,

                      /// style
                      backgroundColor: backgroundColor,
                      cardColor: primaryColor,

                      /// child
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        /// the Title and Washing machine State will be displayed
                        children: [
                          Text(
                            '예약된 세탁기',
                            style: largeTitleTextStyle(color: Colors.white),
                          ),
                          blankBoxH(height: 30),
                          // TODO change tag with uid
                          Hero(
                            tag: 'washing-machine-hero-animation',

                            /// added [DefaultTextStyle] to `nextPage`
                            /// so that no `red-underline` will not displayed
                            flightShuttleBuilder: (
                              flightContext,
                              animation,
                              flightDirection,
                              fromHeroContext,
                              toHeroContext,
                            ) =>
                                DefaultTextStyle(
                              style: DefaultTextStyle.of(toHeroContext).style,
                              child: toHeroContext.widget,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                /// flaticon of washing machine is here
                                SvgPicture.asset(
                                  'images/washing-machine.svg',
                                  width: width / 4,
                                  height: width / 4,
                                ),

                                /// other references displayed here
                                Column(
                                  /// align children to start and center
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '안암점 WM1260',
                                      style: bodyTextStyle(color: Colors.white),
                                    ),
                                    blankBoxH(height: 8),
                                    Text(
                                      '박재용님',
                                      style: headlineTextStyle(
                                          color: Colors.white),
                                    ),
                                    blankBoxH(height: 8),
                                    Text(
                                      '+8210-1234-5678',
                                      style: callOutTextStyle(color: grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          blankBoxH(height: 20),
                        ],
                      ),
                    ),

                    /// the buttons to handle events of the washing machine is placed here
                    /// under neath the white border

                    /// the running button will be at the midddle
                    Expanded(
                      child: Container(
                        /// size
                        // height: double.infinity,
                        width: width,

                        /// style
                        color: backgroundColor,
                        padding: paddingHV(8, 8),

                        /// child
                        child: Column(
                          children: [
                            blankBoxH(height: 20),
                            ListTile(
                              /// the category name
                              title: Text(
                                '본인인증',
                                style: headlineTextStyle(),
                              ),
                              subtitle: Text(
                                tickedLeftTimeInSeconds > 0
                                    ? '$leftMinutes분 $leftSeconds초 남음'
                                    : '시간이 만료되었어요 🥺',
                                style: callOutTextStyle(),
                              ),
                              trailing: TextButton(
                                onPressed: () => tickedLeftTimeInSeconds > 0
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const QRCodeScreen()))
                                    : showCustomSnackbar(
                                        context: context, msg: '다시 예약해주세요 🥺'),
                                child: Text(
                                  'QR\nCODE',
                                  style: bodyTextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: paddingHV(16, 8),
                                  backgroundColor: primaryColor,
                                ),
                              ),
                            ),
                            blankBoxH(height: 20),
                            ListTile(
                              /// the category name
                              title: Text(
                                '세탁 유형 선택',
                                style: headlineTextStyle(),
                              ),

                              /// the subtitle displays list of laundry type
                              /// this is needed for calculation of laundry task time
                              subtitle: Wrap(
                                spacing: 10.0,
                                children: laundryType
                                    .map((e) => ChoiceChip(
                                        label: Text(e),
                                        selected: e == _selectedType,
                                        onSelected: (val) =>
                                            _handleLaundryTypeOnSelected(e),
                                        selectedColor: primaryColor,
                                        backgroundColor: shallowPrimaryColor,
                                        labelStyle: captionTextStyle(
                                          color: e == _selectedType
                                              ? Colors.white
                                              : primaryColor,
                                        )))
                                    .toList(),
                              ),
                            ),
                            blankBoxH(height: 10),
                            ListTile(
                              /// the category name
                              title: Text(
                                '빨래하기',
                                style: headlineTextStyle(),
                              ),
                              subtitle: Text(
                                isEnabled
                                    ? '남은 시간: ${12}시간'
                                    : '빨래를 넣고 돌려보세요 🤩',
                                style: callOutTextStyle(),
                              ),
                              trailing: TextButton(
                                onPressed: _handleRunningButtonOnPressed,
                                child: Text(
                                  '시작',
                                  style: bodyTextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                style: TextButton.styleFrom(
                                  fixedSize: const Size(80, 80),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: paddingHV(16, 8),
                                  backgroundColor: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        }
      }

      /// this should not be shown !
      return blankBoxH();
    });
  }
}
