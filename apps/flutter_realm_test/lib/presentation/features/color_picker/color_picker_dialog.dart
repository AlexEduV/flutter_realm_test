import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/presentation/features/color_picker/color_picker_cubit.dart';
import 'package:test_flutter_project/presentation/features/color_picker/color_picker_identifiers.dart';
import 'package:test_flutter_project/presentation/features/color_picker/color_picker_state.dart';

import '../../../common/constants/app_semantics_labels.dart';
import '../../../l10n/l10n_keys.dart';
import '../../widgets/app_semantics.dart';
import 'widgets/color_item.dart';

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({required this.initialColor, super.key});

  final String initialColor;

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  @override
  void initState() {
    context.read<ColorPickerCubit>().loadColors();

    final initialColor = context.read<ColorPickerCubit>().getColorByName(widget.initialColor);
    context.read<ColorPickerCubit>().updatePickedColor(initialColor);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.orientationOf(context);

    return BlocBuilder<ColorPickerCubit, ColorPickerState>(
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            context.tr(ColorPickerLocaleKeys.pickColorDialogTitle),
            style: AppTextStyles.zonaPro16.copyWith(fontWeight: FontWeight.w700),
          ),
          content: SizedBox(
            width: 300,
            height: orientation == Orientation.portrait ? 360 : 240,
            child: GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 4 : 5,
              crossAxisSpacing: AppDimensions.minorL,
              mainAxisSpacing: AppDimensions.minorL,
              children: List.generate(state.colors.values.length, (index) {
                final color = state.colors.values.toList()[index];
                return ColorItem(
                  color: color,
                  isPicked: state.pickedColor == color,
                  onTap: () => context.read<ColorPickerCubit>().updatePickedColor(color),
                );
              }),
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
                  final colorName = context.read<ColorPickerCubit>().getColorNameFromColor(
                    state.pickedColor,
                  );
                  Navigator.of(context).pop(colorName);
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
      },
    );
  }
}
