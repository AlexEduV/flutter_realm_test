import 'package:flutter/material.dart' show Colors, TextStyle;

extension WhitenTextStyle on TextStyle {
  TextStyle whiten() => copyWith(color: Colors.white);
}
