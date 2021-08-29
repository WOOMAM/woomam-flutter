import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../control_panel/control_panels.dart';

class CustomDrawer extends StatefulWidget {
  final int currentIndex;
  final Function(int) onIndexChange;
  const CustomDrawer({
    Key? key,
    required this.currentIndex,
    required this.onIndexChange,
  }) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  /// `function`
  _handleOnTapped(int index) {
    widget.onIndexChange(index);
    Navigator.pop(context);
  }

  /// `widget` to navigate
  ListTile navigateTabWidget({
    required int index,
    required String title,
    required IconData iconData,
  }) =>
      ListTile(
        leading: Icon(
          iconData,
          color: widget.currentIndex != index ? secondaryColor : textColor,
        ),
        title: Text(
          title,
          style: headlineTextStyle(
              color: widget.currentIndex != index ? secondaryColor : textColor),
        ),
        onTap: () => _handleOnTapped(index),
      );

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    /// build components
    return Container(
      /// style
      height: height,
      width: width * 0.7,
      padding: paddingHV(24, 16),
      decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),

      /// make list
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// personal information
          /// TODO link with user
          RichText(
            text: TextSpan(children: [
              TextSpan(text: '박재용', style: largeTitleTextStyle()),
              TextSpan(text: '\n이 반가워', style: bodyTextStyle()),
            ]),
          ),

          /// tabs
          Column(
            children: [
              navigateTabWidget(
                  index: 0, title: '지도', iconData: FeatherIcons.mapPin),
              navigateTabWidget(
                  index: 1, title: '예약', iconData: FeatherIcons.bookmark),
              navigateTabWidget(
                  index: 2, title: '설정', iconData: FeatherIcons.settings),
            ],
          ),

          /// sign-out
          const ListTile(
            leading: Icon(FeatherIcons.logOut),
            title: Text('로그아웃'),
          ),
        ],
      ),
    );
  }
}
