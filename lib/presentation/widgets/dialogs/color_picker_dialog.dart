import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/common/extensions/string_extension.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_dimensions.dart';
import '../../../common/app_semantics_labels.dart';
import '../../../common/app_text_styles.dart';
import '../../../l10n/l10n_keys.dart';
import '../app_semantics.dart';

class ColorPickerDialog extends StatefulWidget {
  final String initialColor;

  const ColorPickerDialog({required this.initialColor, super.key});

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  final Map<String, Color> colors = {
    'red': Colors.red,
    'pink': Colors.pink,
    'purple': Colors.purple,
    'deepPurple': Colors.deepPurple,
    'indigo': Colors.indigo,
    'blue': Colors.blue,
    'lightBlue': Colors.lightBlue,
    'cyan': Colors.cyan,
    'teal': Colors.teal,
    'green': Colors.green,
    'lightGreen': Colors.lightGreen,
    'lime': Colors.lime,
    'yellow': Colors.yellow,
    'white': Colors.white,
    'orange': Colors.orange,
    'deepOrange': Colors.deepOrange,
    'brown': Colors.brown,
    'grey': Colors.grey,
    'blueGrey': Colors.blueGrey,
    'black': Colors.black,
  };

  Color? pickedColor = Colors.white;

  @override
  void initState() {
    pickedColor = colors.entries
        .firstWhereOrNull((element) => element.key == widget.initialColor.toLowerCase())
        ?.value;
    pickedColor ??= colors.values.firstOrNull;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.orientationOf(context);

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Pick a color',
        style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w700),
      ),
      content: SizedBox(
        width: 300,
        height: orientation == Orientation.portrait ? 360 : 240,
        child: GridView.count(
          crossAxisCount: orientation == Orientation.portrait ? 4 : 5,
          crossAxisSpacing: AppDimensions.minorL,
          mainAxisSpacing: AppDimensions.minorL,
          children: [
            for (Color color in colors.values)
              InkWell(
                borderRadius: BorderRadius.circular(120.0),
                onTap: () {
                  setState(() {
                    pickedColor = color;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: Border.all(color: Colors.black87, width: 3.0),
                  ),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    opacity: pickedColor == color ? 1.0 : 0.0,
                    child: const Icon(Icons.done, color: Colors.black),
                  ),
                ),
              ),
          ],
        ),
      ),
      actions: [
        AppSemantics(
          label: AppSemanticsLabels.dialogCancelButton,
          button: true,
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop(widget.initialColor);
            },
            child: Text(
              context.trRead(L10nKeys.cancelLabel),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        AppSemantics(
          label: AppSemanticsLabels.dialogConfirmButton,
          button: true,
          child: ElevatedButton(
            onPressed: () {
              String? result = colors.entries
                  .firstWhereOrNull((element) => element.value == pickedColor)
                  ?.key
                  .camelCaseToTitle();
              result ??= '';

              Navigator.of(context).pop(result);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey;
                }
                return AppColors.headerColor;
              }),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
            ),
            child: Text(
              context.trRead(L10nKeys.confirmLabel),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
