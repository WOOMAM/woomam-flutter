import 'package:flutter/material.dart';

import 'control_panels.dart';

/// collection of SizedBox
SizedBox blankBoxH({double? height}) => SizedBox(height: height ?? 0.0);

Container blankBoxHWithColor(
        {required BuildContext context,
        required double height,
        required Color? color}) =>
    Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      color: color ?? grey,
    );

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

/// widgets used in differents states
Widget emptyWidget = const Center(child: Text('정보가 없어요 🥺'));
Widget loadingWidget = const Center(child: CircularProgressIndicator(color: secondaryColor));
Widget errorWidget = const Center(child: Text('Error 😵'));
