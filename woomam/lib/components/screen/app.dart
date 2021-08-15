import 'package:flutter/material.dart';

import '../control_panel/control_panels.dart';

/// pages
import 'home.dart';
import 'reservation.dart';
import 'setting.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late int _currentIndex;
  late List<Widget> _bodyChildren;

  @override
  void initState() {
    super.initState();

    /// init variables
    _currentIndex = 0;
    _bodyChildren = const [
      HomeScreen(),
      ReservationScreen(),
      SettingScreen(),
    ];
  }

  /// handle the bottom navigation bar index change
  void _handleIndexChange(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// use IndexedStack to keep scroll alive between taps
      body: IndexedStack(
        index: _currentIndex,
        children: _bodyChildren,
      ),

      /// bottom navigation bar
      /// `extendBody`, *If you want to show body behind the navbar, it should be true*
      extendBody: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _handleIndexChange,
      ),
    );
  }
}
