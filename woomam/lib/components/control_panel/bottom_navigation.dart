import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import './control_panels.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  const CustomBottomNavigationBar(
      {Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return DotNavigationBar(
      /// set currentIndex
      currentIndex: widget.currentIndex,

      /// set onTap
      onTap: widget.onTap,

      /// style
      dotIndicatorColor: primaryColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: unSelectedColor,
      itemPadding: paddingLTRB(left: 16, right: 16, top: 8, bottom: 16),

      /// items displayed
      items: [
        DotNavigationBarItem(
          icon: const Icon(FeatherIcons.mapPin),
        ),
        DotNavigationBarItem(
          icon: const Icon(FeatherIcons.bookmark),
        ),
        DotNavigationBarItem(
          icon: const Icon(FeatherIcons.settings),
        ),
      ],
    );
  }
}
