import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:woomam/components/control_panel/widget.dart';

import '../components.dart';

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
  void _handleRunningButtonOnPressed() =>
      setState(() => isEnabled = !isEnabled);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// the reserved washing machine detail
        /// show Title text and some descriptions for Washing Machine
        bottomRightRoundedBox(
          /// size
          height: height / 3,
          width: width,

          /// style
          backgroundColor: backgroundColor,
          cardColor: Colors.white,

          /// child
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            /// the Title and Washing machine State will be displayed
            children: [
              blankBoxH(60),
              Text(
                '예약된 세탁기',
                style: largeTitleTextStyle(),
              ),
              blankBoxH(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  /// flaticon of washing machine is here
                  Icon(FeatherIcons.aperture,
                      size: width / 4, color: secondaryColor),

                  /// other references displayed here
                  Column(
                    /// align children to start and center
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '안암점 WM1260',
                        style: bodyTextStyle(),
                      ),
                      blankBoxH(8),
                      Text(
                        '박재용님',
                        style: headlineTextStyle(),
                      ),
                      blankBoxH(8),
                      Text(
                        '+8210-1234-5678',
                        style: callOutTextStyle(),
                      ),
                    ],
                  )
                ],
              ),
              blankBoxH(20),
            ],
          ),
        ),

        /// the buttons to handle events of the washing machine is placed here
        /// under neath the white border

        /// the running button will be at the midddle
        bottomRightRoundedBox(
          /// size
          height: height / 3,
          width: width,

          /// style
          backgroundColor: primaryColor,
          cardColor: backgroundColor,

          /// child
          child: Column(
            children: [
              blankBoxH(20),
              ListTile(
                /// the category name
                title: Text(
                  '세탁 유형 선택',
                  style: titleTextStyle(),
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
                          backgroundColor: Colors.white38,
                          labelStyle: TextStyle(
                              color: e == _selectedType
                                  ? Colors.white
                                  : primaryColor)))
                      .toList(),
                ),
              ),
              blankBoxH(10),
              ListTile(
                /// the category name
                title: Text('본인인증', style: titleTextStyle()),
                subtitle: TextButton(
                  onPressed: () {},
                  child: Text(
                    '세탁기 앞 QR 코드를 찍어주세요',
                    style: headlineTextStyle(color: Colors.white),
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
        Expanded(
          child: Container(
            color: primaryColor,
            padding: paddingHV(16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(isEnabled ? '남은 시간: ${12}시간' : '빨래를 넣고 돌려보세요 🤩',
                    style: headlineTextStyle(color: Colors.white)),
                    /// TODO: check the washing machine has closed well !
                TextButton(
                  onPressed: _handleRunningButtonOnPressed,
                  child:
                      Text('빨래하기', style: headlineTextStyle(color: primaryColor)),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      padding: paddingHV(16, 8)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
