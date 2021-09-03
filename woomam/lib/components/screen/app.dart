import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woomam/bloc/bloc.dart';
import '../control_panel/control_panels.dart';

/// pages
import 'home/home.dart';
import 'reservation/reservation.dart';
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
      ReservationScreen(
        userPhoneNumber: '01079074244',
      ),
      SettingScreen(),
    ];
  }

  /// handle the bottom navigation bar index change
  void _handleIndexChange(int index) {
    /// add events to get new information from server
    if (index == 1) {
      BlocProvider.of<WashingMachineBloc>(context)
          .add(GetReservationInformationEvent(userPhoneNumber: '01079074244'));
    }

    /// change index
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    /// used `AnnotatedRegion` to handle the status bar style
    return AnnotatedRegion<SystemUiOverlayStyle>(
      /// status bar mode
      value: _currentIndex == 1
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: Scaffold(
        /// fills the `status color`
        backgroundColor: _currentIndex == 1 ? primaryColor : backgroundColor,

        /// will be not using Appbar, just using one body
        /// wrap with `SliderMenuContainer` to use slider_drawer
        body: IndexedStack(
          index: _currentIndex,
          children: _bodyChildren,
        ),

        /// moved to drawer instead of bottom navigation bar
        drawer: CustomDrawer(
          currentIndex: _currentIndex,
          onIndexChange: _handleIndexChange,
        ),
      ),
    );
  }
}
