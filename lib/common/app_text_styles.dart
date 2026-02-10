import 'package:flutter/cupertino.dart' show FontWeight, TextStyle;
import 'package:flutter/material.dart' show Colors;

class AppTextStyles {
  static const zonaPro14 = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
  static const zonaPro16 = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
  static const zonaPro18 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  static const zonaPro20 = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
  static const zonaPro24 = TextStyle(fontSize: 24, fontWeight: FontWeight.w600);
  static const zonaPro30 = TextStyle(fontSize: 30, fontWeight: FontWeight.w700);

  static final zonaPro30White = zonaPro30.copyWith(color: Colors.white);
  static final zonaPro24White = zonaPro24.copyWith(color: Colors.white);

  static final zonaPro16Grey = zonaPro16.copyWith(color: Colors.grey[700]);
}
