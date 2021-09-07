import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

/// bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woomam/bloc/bloc.dart';

/// components
import 'package:woomam/components/control_panel/control_panels.dart';
import 'package:woomam/components/screen/app.dart';
import 'package:woomam/components/screen/user/sign_in.dart';

class CustomRouter extends StatefulWidget {
  const CustomRouter({Key? key}) : super(key: key);

  @override
  _CustomRouterState createState() => _CustomRouterState();
}

class _CustomRouterState extends State<CustomRouter> {
  /// check user with firebase
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    if (_auth.currentUser != null) {
      /// has logged-in before
      BlocProvider.of<UserBloc>(context).add(SignInEvent(
        phoneNumber: _auth.currentUser!.phoneNumber!,
        uuid: _auth.currentUser!.uid,
      ));
    } else {
      /// none of  user information
      /// needs user sign-in
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is UserEmpty) {
        /// need to sign-in
        return const SignInScreen();
      } else if (state is UserLoading) {
        return loadingWidget;
      } else if (state is UserError) {
        return errorWidget;
      } else if (state is UserLoaded) {
        return const RootScreen();
      }
      return errorWidget;
    });
  }
}
