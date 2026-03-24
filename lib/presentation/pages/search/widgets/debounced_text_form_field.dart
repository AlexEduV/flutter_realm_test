import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';

class DebouncedTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final void Function(String value) onDebouncedChanged;
  final String? errorText;

  const DebouncedTextFormField({
    required this.controller,
    required this.label,
    required this.onDebouncedChanged,
    this.errorText,
    super.key,
  });

  @override
  State<DebouncedTextFormField> createState() => _DebouncedTextFormFieldState();
}

class _DebouncedTextFormFieldState extends State<DebouncedTextFormField> {
  Timer? _debounce;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (!_focusNode.hasFocus) return;

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      // Unfocus the field
      _focusNode.unfocus();
      // Pass value to cubit
      widget.onDebouncedChanged(widget.controller.text);
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    _debounce?.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppDimensions.minorL);

    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      decoration: InputDecoration(
        errorText: widget.errorText,
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppDimensions.minorS,
          horizontal: AppDimensions.minorL,
        ),
        fillColor: Colors.white,
        filled: true,
        labelText: widget.label,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey),
          borderRadius: borderRadius,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.lightGrey),
          borderRadius: borderRadius,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.placeholderColorDark),
          borderRadius: borderRadius,
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
