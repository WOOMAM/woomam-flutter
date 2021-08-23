import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woomam/components/control_panel/widget.dart';
import 'package:woomam/components/screen/washing_machine/running_washing_machine.dart';

import '../../components.dart';

final List<String> laundryType = ['표준', '소량/쾌속', '타월', '이불세탁', '삶음', '무세제통세척'];

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  /// variables
  late bool isEnabled;
  late String _selectedType;

  @override
  void initState() {
    super.initState();

    /// init variables
    isEnabled = true;
    _selectedType = '';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// the reserved washing machine detail
        /// show Title text and some descriptions for Washing Machine
        /// TODO change tag with uid
        bottomRightRoundedBox(
          /// size
          height: height / 3,
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
              blankBoxH(50),
              Text(
                '예약된 세탁기',
                style: titleTextStyle(color: Colors.white),
              ),
              blankBoxH(30),
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
                        blankBoxH(8),
                        Text(
                          '박재용님',
                          style: headlineTextStyle(color: Colors.white),
                        ),
                        blankBoxH(8),
                        Text(
                          '+8210-1234-5678',
                          style: callOutTextStyle(color: grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              blankBoxH(20),
            ],
          ),
        ),

        /// the buttons to handle events of the washing machine is placed here
        /// under neath the white border

        /// the running button will be at the midddle
        Container(
          /// size
          height: height / 3,
          width: width,

          /// style
          color: backgroundColor,
          padding: paddingHV(8, 8),

          /// child
          child: Column(
            children: [
              blankBoxH(20),
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
                          onSelected: (val) => _handleLaundryTypeOnSelected(e),
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
              blankBoxH(10),
              ListTile(
                /// the category name
                title: Text('본인인증', style: headlineTextStyle()),
                subtitle: TextButton(
                  onPressed: () {},
                  child: Text(
                    '세탁기 앞 QR 코드를 찍어주세요',
                    style: bodyTextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: paddingHV(16, 8),
                    backgroundColor: primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
            padding: paddingHV(8, 8),
            child: ListTile(
              title: Text(isEnabled ? '남은 시간: ${12}시간' : '빨래를 넣고 돌려보세요 🤩',
                  style: headlineTextStyle()),

              /// TODO: check the washing machine has closed well !
              subtitle: TextButton(
                onPressed: _handleRunningButtonOnPressed,
                child:
                    Text('빨래하기', style: headlineTextStyle(color: Colors.white)),
                style: TextButton.styleFrom(
                    backgroundColor: secondaryColor,
                    shape: const StadiumBorder(),
                    padding: paddingHV(16, 8)),
              ),
            )),
      ],
    );
  }
}
