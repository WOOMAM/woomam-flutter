import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import 'control_panels.dart';

/// collection of SizedBox
SizedBox blankBoxH(double height) => SizedBox(height: height);

/// The BottomRightRounded Container widget
Widget bottomRightRoundedBox(
        {required double height,
        required double width,
        required Color backgroundColor,
        required Color cardColor,
        required Widget child}) =>
    Stack(children: [
      /// background
      Container(
        width: width,
        height: height,
        color: backgroundColor,
      ),

      /// card
      Container(

          /// size
          height: height,
          width: width,

          /// decoration
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.only(bottomRight: Radius.circular(width / 5.5)),
            color: cardColor,
          ),

          /// alignment
          alignment: Alignment.centerLeft,
          padding: paddingHV(16, 8),
          child: child),
    ]);
