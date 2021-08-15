import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:woomam/components/control_panel/widget.dart';

import '../components.dart';

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({Key? key}) : super(key: key);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        /// the reserved washing machine detail
        /// show Title text and some descriptions for Washing Machine
        Container(
          /// size
          height: height / 3,
          width: width,

          /// decoration
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(width / 4)),
            color: Colors.white,
          ),

          /// alignment
          alignment: Alignment.centerLeft,
          padding: paddingHV(16, 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,

            /// the Title and Washing machine State will be displayed
            children: [
              blankBoxH(60),
              const Text(
                '예약된 세탁기',
                style: largeTitleTextStyle,
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
                      const Text(
                        '안암점 WM1260',
                        style: bodyTextStyle,
                      ),
                      blankBoxH(8),
                      const Text(
                        '박재용님',
                        style: headlineTextStyle,
                      ),
                      blankBoxH(8),
                      const Text(
                        '+8210-1234-5678',
                        style: callOutTextStyle,
                      ),
                    ],
                  )
                ],
              ),
              blankBoxH(20),
            ],
          ),
        ),
      ],
    );
  }
}
