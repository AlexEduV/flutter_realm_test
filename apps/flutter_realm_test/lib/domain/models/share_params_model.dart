import 'dart:ui';

import 'package:share_plus/share_plus.dart';

class ShareParamsModel {
  final String title;
  final String text;
  final Rect? sharePositionOrigin;

  ShareParamsModel({required this.title, required this.text, this.sharePositionOrigin});

  ShareParamsModel copyWith({String? title, String? text, Rect? sharePositionOrigin}) {
    return ShareParamsModel(
      title: title ?? this.title,
      text: text ?? this.text,
      sharePositionOrigin: sharePositionOrigin ?? this.sharePositionOrigin,
    );
  }

  ShareParams toShareParams() {
    return ShareParams(title: title, text: text, sharePositionOrigin: sharePositionOrigin);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShareParamsModel &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          text == other.text &&
          sharePositionOrigin == other.sharePositionOrigin;

  @override
  int get hashCode => title.hashCode ^ text.hashCode ^ (sharePositionOrigin?.hashCode ?? 0);
}
