import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_futter_project/common/app_colors.dart';
import 'package:test_futter_project/common/app_constants.dart';
import 'package:test_futter_project/common/app_text_styles.dart';
import 'package:test_futter_project/common/enums/body_type.dart';
import 'package:test_futter_project/common/enums/fuel_type.dart';
import 'package:test_futter_project/common/enums/transmission_type.dart';
import 'package:test_futter_project/presentation/bloc/home/new_item_page/new_item_page_cubit.dart';
import 'package:test_futter_project/presentation/pages/home/new_item_page/sub_pages/car_type_picker.dart';
import 'package:test_futter_project/presentation/pages/home/new_item_page/sub_pages/item_info_form.dart';

import '../../../../common/app_dimensions.dart';
import '../../../../common/app_semantics_labels.dart';
import '../../../widgets/app_semantics.dart';

class NewItemPage extends StatefulWidget {
  const NewItemPage({super.key});

  @override
  State<NewItemPage> createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  final pageViewController = PageController();

  final manufacturerFocusNode = FocusNode();
  final modelFocusNode = FocusNode();
  final yearFocusNode = FocusNode();
  final colorFocusNode = FocusNode();

  BodyType? selectedBodyType = BodyType.sedan;
  TransmissionType? selectedTransmissionType = TransmissionType.manual;
  FuelType? selectedFuelType = FuelType.diesel;

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
          children: [
            Expanded(
              child: PageView(
                controller: pageViewController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const CarTypePicker(),

                  ItemInfoForm(
                    manufacturerFocusNode: manufacturerFocusNode,
                    modelFocusNode: modelFocusNode,
                    colorFocusNode: colorFocusNode,
                    yearFocusNode: yearFocusNode,
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppDimensions.minorL,
              children: [
                IconButton(
                  onPressed: () {
                    final cubit = context.read<NewItemPageCubit>();

                    final currentIndex = cubit.state.currentPageIndex;
                    cubit.updateTabIndex(currentIndex - 1);

                    pageViewController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );

                    clearAllFocuses();
                  },
                  icon: const Icon(Icons.chevron_left_outlined, color: AppColors.headerColor),
                ),
                IconButton(
                  onPressed: () {
                    final cubit = context.read<NewItemPageCubit>();

                    if (cubit.state.currentPageIndex == AppConstants.itemSetupTabInfo) {
                      final areAllFieldsValid = cubit.areAllFieldsValid();

                      if (!areAllFieldsValid) return;
                    }

                    pageViewController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );

                    final currentIndex = cubit.state.currentPageIndex;
                    cubit.updateTabIndex(currentIndex + 1);

                    clearAllFocuses();
                  },
                  icon: const Icon(Icons.chevron_right_outlined, color: AppColors.headerColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void clearAllFocuses() {
    manufacturerFocusNode.unfocus();
    modelFocusNode.unfocus();
    yearFocusNode.unfocus();
    colorFocusNode.unfocus();
  }
}
