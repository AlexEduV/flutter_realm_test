import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;

class AppTextStyles {
  static final zonaPro16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static final zonaPro18 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static final zonaPro20 = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static final zonaPro24 = TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
  static final zonaPro30 = TextStyle(fontSize: 30, fontWeight: FontWeight.w700);

  static final zonaPro30White = zonaPro30.copyWith(color: Colors.white);
  static final zonaPro24White = zonaPro24.copyWith(color: Colors.white);
}
