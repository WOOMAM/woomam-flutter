import 'package:flutter/material.dart';

import '../control_panel/control_panels.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();

    /// init variables
    currentIndex = 0;
  }

  void _handleIndexChange(int index) => setState(() => currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SizedBox(),
      extendBody: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _handleIndexChange,
      ),
    );
  }
}
