import 'package:flutter/material.dart';

/// control-panel
import 'package:woomam/components/components.dart';

/// fontSize 32 bold primaryColor
TextStyle largeTitleTextStyle({Color? color}) => TextStyle(
    fontSize: 32, fontWeight: FontWeight.w800, color: color ?? textColor);

/// fontSize 24 Semi-bold primaryColor
TextStyle titleTextStyle({Color? color}) => TextStyle(
    fontSize: 24, fontWeight: FontWeight.bold, color: color ?? textColor);

/// fontSize 17 bold primaryColor
TextStyle headlineTextStyle({Color? color}) => TextStyle(
    fontSize: 17, fontWeight: FontWeight.w600, color: color ?? textColor);

/// fontSize 17 Medium primaryColor
TextStyle bodyTextStyle({Color? color}) => TextStyle(
    fontSize: 17, fontWeight: FontWeight.w500, color: color ?? primaryColor);

/// fontSize 15 Regular primaryColor
TextStyle callOutTextStyle({Color? color}) => TextStyle(
    fontSize: 15, fontWeight: FontWeight.w400, color: color ?? secondaryColor);

/// fontSize 13 Regular primaryColor
TextStyle captionTextStyle({Color? color}) => TextStyle(
    fontSize: 13, fontWeight: FontWeight.w400, color: color ?? secondaryColor);
