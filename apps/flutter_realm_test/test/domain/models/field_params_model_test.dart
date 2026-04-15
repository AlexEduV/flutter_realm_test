import 'package:flutter_test/flutter_test.dart';
import 'package:test_flutter_project/domain/models/field_params_model.dart';

void main() {
  group('FieldParamsModel', () {
    test('constructor sets all fields correctly', () {
      const model = FieldParamsModel(
        label: 'Username',
        validationMessage: 'Required',
        regex: r'^[a-zA-Z0-9]+$',
        regexErrorMessage: 'Invalid format',
        minLength: 3,
        maxLength: 12,
        minLengthErrorMessage: 'Too short',
        maxLengthErrorMessage: 'Too long',
      );

      expect(model.label, 'Username');
      expect(model.validationMessage, 'Required');
      expect(model.regex, r'^[a-zA-Z0-9]+$');
      expect(model.regexErrorMessage, 'Invalid format');
      expect(model.minLength, 3);
      expect(model.maxLength, 12);
      expect(model.minLengthErrorMessage, 'Too short');
      expect(model.maxLengthErrorMessage, 'Too long');
    });

    test('withLabel factory sets label and defaults', () {
      final model = FieldParamsModel.withLabel('Email');

      expect(model.label, 'Email');
      expect(model.validationMessage, '');
      expect(model.regex, '');
      expect(model.regexErrorMessage, '');
      expect(model.minLength, isNull);
      expect(model.maxLength, isNull);
      expect(model.minLengthErrorMessage, isNull);
      expect(model.maxLengthErrorMessage, isNull);
    });

    test('copyWith returns a new instance with updated fields', () {
      const original = FieldParamsModel(
        label: 'Password',
        validationMessage: 'Required',
        regex: r'.*',
        regexErrorMessage: 'Invalid',
      );

      final updated = original.copyWith(
        label: 'New Password',
        minLength: 8,
        minLengthErrorMessage: 'Too short',
      );

      expect(updated.label, 'New Password');
      expect(updated.validationMessage, 'Required');
      expect(updated.regex, r'.*');
      expect(updated.regexErrorMessage, 'Invalid');
      expect(updated.minLength, 8);
      expect(updated.minLengthErrorMessage, 'Too short');
      expect(updated.maxLength, isNull);
      expect(updated.maxLengthErrorMessage, isNull);
    });

    test('copyWith returns original when no parameters are provided', () {
      const original = FieldParamsModel(
        label: 'Phone',
        validationMessage: 'Required',
        regex: r'\d+',
        regexErrorMessage: 'Invalid',
      );

      final copy = original.copyWith();

      expect(copy.label, original.label);
      expect(copy.validationMessage, original.validationMessage);
      expect(copy.regex, original.regex);
      expect(copy.regexErrorMessage, original.regexErrorMessage);
      expect(copy.minLength, original.minLength);
      expect(copy.maxLength, original.maxLength);
      expect(copy.minLengthErrorMessage, original.minLengthErrorMessage);
      expect(copy.maxLengthErrorMessage, original.maxLengthErrorMessage);
    });
  });
}
