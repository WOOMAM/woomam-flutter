import 'package:flutter/material.dart';

import './typography.dart';

showCustomSnackbar({required BuildContext context, required String msg}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
      msg,
      style: callOutTextStyle(
        color: Colors.white,
      ),
    )));
