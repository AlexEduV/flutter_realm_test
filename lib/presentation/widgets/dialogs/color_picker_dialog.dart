import 'package:flutter/material.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';

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
  final List<Color> colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.white,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];

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
            for (Color color in colors)
              InkWell(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: Border.all(color: Colors.black87, width: 3.0),
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
              Navigator.of(context).pop();
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
              Navigator.of(context).pop();
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
