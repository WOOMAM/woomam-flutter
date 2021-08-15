import 'package:flutter/material.dart';
import 'package:woomam/components/components.dart';

/// pages
import 'package:woomam/components/screen/app.dart';

/// component

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: customThemeData,
      home: const RootScreen(),
    );
  }
}