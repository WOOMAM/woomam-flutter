import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/// bloc & repository
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woomam/components/screen/route.dart';
import './bloc/bloc.dart';
import './respository/repository.dart';

/// config
import 'package:flutter_config/flutter_config.dart';

/// component
import 'package:woomam/components/components.dart';

void main() async {
  /// requirements for FlutterConfig and Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  /// requirements for Firebase
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();

  /// run app
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (context) =>
              UserBloc(userRepository: UserRepository(prefs: prefs))),
      BlocProvider(
          create: (context) =>
              StoreBloc(storeRespository: StoreRespository(prefs: prefs))),
      BlocProvider(
          create: (context) => WashingMachineBloc(
              washingMachineRepository:
                  WashingMachineRepository(prefs: prefs))),
    ],
    child: const MyApp(),
  ));
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
      home: const CustomRouter(),
    );
  }
}
