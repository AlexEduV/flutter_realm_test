import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/domain/models/share_params_model.dart';

void main() {
  group('ShareParamsModel', () {
    test('should assign properties via constructor', () {
      final rect = const Rect.fromLTWH(0, 0, 100, 100);
      final model = ShareParamsModel(title: 'Title', text: 'Text', sharePositionOrigin: rect);

      expect(model.title, 'Title');
      expect(model.text, 'Text');
      expect(model.sharePositionOrigin, rect);
    });

    test('should assign null to sharePositionOrigin if not provided', () {
      final model = ShareParamsModel(title: 'Title', text: 'Text');
      expect(model.sharePositionOrigin, isNull);
    });

    test('copyWith should override provided fields', () {
      final rect1 = const Rect.fromLTWH(0, 0, 100, 100);
      final rect2 = const Rect.fromLTWH(10, 10, 50, 50);
      final model = ShareParamsModel(title: 'Title', text: 'Text', sharePositionOrigin: rect1);

      final copy = model.copyWith(title: 'NewTitle', text: 'NewText', sharePositionOrigin: rect2);

      expect(copy.title, 'NewTitle');
      expect(copy.text, 'NewText');
      expect(copy.sharePositionOrigin, rect2);
    });

    test('copyWith should keep original values if not provided', () {
      final rect = const Rect.fromLTWH(0, 0, 100, 100);
      final model = ShareParamsModel(title: 'Title', text: 'Text', sharePositionOrigin: rect);

      final copy = model.copyWith();

      expect(copy.title, model.title);
      expect(copy.text, model.text);
      expect(copy.sharePositionOrigin, model.sharePositionOrigin);
    });

    test('toShareParams should convert to ShareParams', () {
      final rect = const Rect.fromLTWH(0, 0, 100, 100);
      final model = ShareParamsModel(title: 'Title', text: 'Text', sharePositionOrigin: rect);

      final shareParams = model.toShareParams();

      expect(shareParams.title, model.title);
      expect(shareParams.text, model.text);
      expect(shareParams.sharePositionOrigin, model.sharePositionOrigin);
    });

    test('should be equal if all fields are the same', () {
      final rect = const Rect.fromLTWH(0, 0, 100, 100);
      final model1 = ShareParamsModel(title: 'Title', text: 'Text', sharePositionOrigin: rect);
      final model2 = ShareParamsModel(title: 'Title', text: 'Text', sharePositionOrigin: rect);

      expect(model1, model2);
      expect(model1.hashCode, model2.hashCode);
    });

    test('should not be equal if any field is different', () {
      final rect = const Rect.fromLTWH(0, 0, 100, 100);
      final model1 = ShareParamsModel(title: 'Title', text: 'Text', sharePositionOrigin: rect);
      final model2 = ShareParamsModel(title: 'Title', text: 'Different', sharePositionOrigin: rect);
      final model3 = ShareParamsModel(title: 'Different', text: 'Text', sharePositionOrigin: rect);
      final model4 = ShareParamsModel(title: 'Title', text: 'Text', sharePositionOrigin: null);

      expect(model1 == model2, isFalse);
      expect(model1 == model3, isFalse);
      expect(model1 == model4, isFalse);
    });

    test('should be identical to itself', () {
      final model = ShareParamsModel(title: 'Title', text: 'Text');
      expect(identical(model, model), isTrue);
      expect(model == model, isTrue);
    });
  });
}
