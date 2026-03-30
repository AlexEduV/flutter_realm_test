import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/presentation/pages/authentication/widgets/app_form_field.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_semantics_labels.dart';
import '../../../widgets/app_semantics.dart';

class NewItemPage extends StatefulWidget {
  const NewItemPage({super.key});

  @override
  State<NewItemPage> createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  final manufacturerFocusNode = FocusNode();
  final modelFocusNode = FocusNode();
  final yearFocusNode = FocusNode();
  final colorFocusNode = FocusNode();

  final manufacturerTextController = TextEditingController();
  final modelTextController = TextEditingController();
  final yearTextController = TextEditingController();
  final colorTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add new item', style: AppTextStyles.zonaPro20),
        leading: AppSemantics(
          label: AppSemanticsLabels.backButton,
          button: true,
          child: IconButton(
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              }
            },
            icon: const Icon(
              Icons.arrow_back,
              size: AppDimensions.appBarIconSize,
              color: AppColors.headerColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          vertical: AppDimensions.normalL,
          horizontal: AppDimensions.normalM,
        ),
        child: Column(
          spacing: AppDimensions.normalS,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What kind of an item would you like to add?',
              style: AppTextStyles.zonaPro14,
            ),

            AppFormField(
              focusNode: manufacturerFocusNode,
              textEditingController: manufacturerTextController,
              labelText: 'Manufacturer',
              hintText: 'Manufacturer',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFocusChange: (hasFocus) {},
              onChanged: (newText) {},
              padding: 0.0,
            ),

            AppFormField(
              focusNode: modelFocusNode,
              textEditingController: modelTextController,
              labelText: 'Model',
              hintText: 'Model',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFocusChange: (hasFocus) {},
              onChanged: (newText) {},
              padding: 0.0,
            ),

            AppFormField(
              focusNode: yearFocusNode,
              textEditingController: yearTextController,
              labelText: 'Year',
              hintText: 'Year',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFocusChange: (hasFocus) {},
              onChanged: (newText) {},
              padding: 0.0,
            ),

            AppFormField(
              focusNode: colorFocusNode,
              textEditingController: colorTextController,
              labelText: 'Color',
              hintText: 'Color',
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onFocusChange: (hasFocus) {},
              onChanged: (newText) {},
              padding: 0.0,
            ),
          ],
        ),
      ),
    );
  }
}
