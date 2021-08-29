import 'package:flutter/material.dart';

/// config
import 'package:flutter_config/flutter_config.dart';

/// pages
import 'package:woomam/components/screen/app.dart';

/// component
import 'package:woomam/components/components.dart';

void main() async {
  /// requirements for FlutterConfig
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  /// run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      /// style
      theme: customThemeData,
      
      /// display
      home: const RootScreen(),
    );
  }
}
