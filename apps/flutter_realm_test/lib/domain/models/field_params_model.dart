class FieldParamsModel {
  final String label;
  final String? hintText;
  final int? maxLength;
  final int? minLength;
  final String? minLengthErrorMessage;
  final String? maxLengthErrorMessage;
  final String validationMessage;
  final String regexErrorMessage;
  final String regex;

  const FieldParamsModel({
    required this.label,
    required this.validationMessage,
    required this.regex,
    required this.regexErrorMessage,
    this.hintText,
    this.minLength,
    this.maxLength,
    this.minLengthErrorMessage,
    this.maxLengthErrorMessage,
  });

  factory FieldParamsModel.withLabel(String label) {
    return FieldParamsModel(label: label, validationMessage: '', regex: '', regexErrorMessage: '');
  }

  FieldParamsModel copyWith({
    String? label,
    int? maxLength,
    int? minLength,
    String? minLengthErrorMessage,
    String? maxLengthErrorMessage,
    String? validationMessage,
    String? regexErrorMessage,
    String? regex,
    String? hintText,
  }) {
    return FieldParamsModel(
      label: label ?? this.label,
      maxLength: maxLength ?? this.maxLength,
      minLength: minLength ?? this.minLength,
      minLengthErrorMessage: minLengthErrorMessage ?? this.minLengthErrorMessage,
      maxLengthErrorMessage: maxLengthErrorMessage ?? this.maxLengthErrorMessage,
      validationMessage: validationMessage ?? this.validationMessage,
      regexErrorMessage: regexErrorMessage ?? this.regexErrorMessage,
      regex: regex ?? this.regex,
      hintText: hintText ?? this.hintText,
    );
  }
}
