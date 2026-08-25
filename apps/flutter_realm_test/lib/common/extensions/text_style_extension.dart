import 'dart:ui';

import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart' show TextStyle;

extension WhitenTextStyle on TextStyle {
  TextStyle whiten() => copyWith(color: AppColors.white);
}

extension EmboldenTextStyle on TextStyle {
  TextStyle embolden() => copyWith(fontWeight: FontWeight(fontWeight?.value ?? 0 + 200));
}
