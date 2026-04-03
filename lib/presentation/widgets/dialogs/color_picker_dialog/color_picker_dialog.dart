import 'package:flutter/material.dart';
import 'package:test_futter_project/common/extensions/context_extension.dart';
import 'package:test_futter_project/core/di/injection_container.dart';
import 'package:test_futter_project/domain/usecases/car_colors/get_car_color_by_name_use_case.dart';
import 'package:test_futter_project/domain/usecases/car_colors/get_car_color_name_from_color_use_case.dart';
import 'package:test_futter_project/domain/usecases/car_colors/get_car_colors_use_case.dart';

import '../../../../common/app_colors.dart';
import '../../../../common/app_dimensions.dart';
import '../../../../common/app_semantics_labels.dart';
import '../../../../common/app_text_styles.dart';
import '../../../../l10n/l10n_keys.dart';
import '../../app_semantics.dart';
import 'color_item.dart';

class ColorPickerDialog extends StatefulWidget {
  final String initialColor;

  const ColorPickerDialog({required this.initialColor, super.key});

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  final Map<String, Color> colors = serviceLocator<GetCarColorsUseCase>().call();

  Color? pickedColor = Colors.white;

  @override
  void initState() {
    pickedColor = serviceLocator<GetCarColorByNameUseCase>().call(widget.initialColor);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.orientationOf(context);

    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        context.tr(L10nKeys.pickColorDialogTitle),
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
              ColorItem(
                color: color,
                isPicked: pickedColor == color,
                onTap: () {
                  setState(() {
                    pickedColor = color;
                  });
                },
              ),
          ],
        ),
      ),
      actions: [
        AppSemantics(
          label: AppSemanticsLabels.dialogCancelButton,
          button: true,
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(widget.initialColor),
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
              final result = serviceLocator<GetCarColorNameFromColorUseCase>().call(pickedColor);

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
