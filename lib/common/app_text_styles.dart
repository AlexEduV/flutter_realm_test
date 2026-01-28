import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;

class AppTextStyles {
  static final roboto16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static final roboto18 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static final roboto20 = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static final roboto24 = TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
  static final roboto24White = roboto24.copyWith(color: Colors.white);
}
