import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_futter_project/domain/models/share_params_model.dart';

void main() {
  group('ShareParamsModel', () {
    test('constructor assigns values correctly', () {
      final rect = const Rect.fromLTWH(0, 0, 100, 100);
      final model = ShareParamsModel(title: 'Title', text: 'Text', sharePositionOrigin: rect);

      expect(model.title, 'Title');
      expect(model.text, 'Text');
      expect(model.sharePositionOrigin, rect);
    });

    test('copyWith returns a new instance with updated values', () {
      final rect1 = const Rect.fromLTWH(0, 0, 100, 100);
      final rect2 = const Rect.fromLTWH(10, 10, 50, 50);
      final model = ShareParamsModel(title: 'Title', text: 'Text', sharePositionOrigin: rect1);

      final copy = model.copyWith(title: 'New Title', sharePositionOrigin: rect2);

      expect(copy.title, 'New Title');
      expect(copy.text, 'Text');
      expect(copy.sharePositionOrigin, rect2);
    });

    test('copyWith returns identical instance if no arguments are provided', () {
      final rect = const Rect.fromLTWH(0, 0, 100, 100);
      final model = ShareParamsModel(title: 'Title', text: 'Text', sharePositionOrigin: rect);

      final copy = model.copyWith();

      expect(copy.title, model.title);
      expect(copy.text, model.text);
      expect(copy.sharePositionOrigin, model.sharePositionOrigin);
      expect(copy, isNot(same(model))); // Should be a new instance
    });

    test('toShareParams returns correct ShareParams', () {
      final rect = const Rect.fromLTWH(0, 0, 100, 100);
      final model = ShareParamsModel(title: 'Title', text: 'Text', sharePositionOrigin: rect);

      final params = model.toShareParams();

      expect(params.title, 'Title');
      expect(params.text, 'Text');
      expect(params.sharePositionOrigin, rect);
    });
  });
}
