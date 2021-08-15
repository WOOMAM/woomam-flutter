import 'package:flutter/material.dart';


EdgeInsets paddingHV(double h, double v) => EdgeInsets.symmetric(horizontal: h, vertical: v);
EdgeInsets paddingLTRB({double? left, double? right, double? top, double? bottom}) => EdgeInsets.fromLTRB(left?? 0.0, top??0.0, right??0.0, bottom??0.0);