import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woomam/components/screen/user/sign_in.dart';
import './bloc/bloc.dart';

/// bloc & repository
import './respository/repository.dart';

/// config
import 'package:flutter_config/flutter_config.dart';

/// pages
import 'package:woomam/components/screen/app.dart';

/// component
import 'package:woomam/components/components.dart';

void main() async {
  /// requirements for FlutterConfig and Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  /// requirements for Firebase
  await Firebase.initializeApp();
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwaG9uZU51bWJlciI6IjAxMDc5MDc0MjQ0IiwiaWF0IjoxNjMwMjExMDMxLCJleHAiOjE2MzAyNTQyMzF9.M414ciIwjahfwpNJomM7zWENVi1JR8itBthWmh7TbSg';

  /// run app
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (context) =>
              StoreBloc(storeRespository: StoreRespository(token: token))),
      BlocProvider(
          create: (context) => WashingMachineBloc(
              washingMachineRepository:
                  WashingMachineRepository(token: token))),
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
      // home: const RootScreen(),
      home: const SignInScreen()
    );
  }
}