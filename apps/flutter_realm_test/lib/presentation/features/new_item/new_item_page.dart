import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter_project/common/constants/app_routes.dart';
import 'package:test_flutter_project/common/enums/item_setup_tab.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/presentation/features/home/home_page_params.dart';
import 'package:test_flutter_project/presentation/features/new_item/new_item_page_cubit.dart';
import 'package:test_flutter_project/presentation/features/new_item/sub_pages/car_type_picker.dart';
import 'package:test_flutter_project/presentation/features/new_item/sub_pages/item_info_form.dart';
import 'package:test_flutter_project/presentation/features/new_item/sub_pages/item_specs_picker.dart';
import 'package:test_flutter_project/presentation/features/new_item/widgets/page_selection_bar.dart';

import '../explore/explore_page_cubit.dart';
import 'new_item_page_identifiers.dart';
import 'new_item_page_state.dart';

class NewItemPage extends StatefulWidget {
  const NewItemPage({super.key});

  @override
  State<NewItemPage> createState() => _NewItemPageState();
}

class _NewItemPageState extends State<NewItemPage> {
  final _pageViewController = PageController();

  final _manufacturerFocusNode = FocusNode();
  final _modelFocusNode = FocusNode();
  final _yearFocusNode = FocusNode();
  final _colorFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    final initIndex = ItemSetupTab.type.index;

    final cubit = context.read<NewItemPageCubit>()..init();
    cubit.updateTabIndex(initIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageViewController.jumpToPage(initIndex);
    });

    cubit.clearFields();
  }

  @override
  void dispose() {
    _manufacturerFocusNode.dispose();
    _modelFocusNode.dispose();
    _yearFocusNode.dispose();
    _priceFocusNode.dispose();
    _colorFocusNode.dispose();

    _pageViewController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          context.tr(NewItemPageLocaleKeys.addNewItemPageTitle),
          style: AppTextStyles.zonaPro20,
        ),
      ),
      body: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          Padding(
            padding: const EdgeInsetsGeometry.symmetric(
              vertical: AppDimensions.normalL,
              horizontal: AppDimensions.normalM,
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageViewController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const CarTypePicker(),

                      ItemInfoForm(
                        manufacturerFocusNode: _manufacturerFocusNode,
                        modelFocusNode: _modelFocusNode,
                        colorFocusNode: _colorFocusNode,
                        yearFocusNode: _yearFocusNode,
                        priceFocusNode: _priceFocusNode,
                      ),

                      const ItemSpecsPicker(),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: AppDimensions.majorS,
            child: BlocBuilder<NewItemPageCubit, NewItemPageState>(
              builder: (context, state) {
                return PageSelectionBar(
                  onBackPressed: () => pageLeftPressed(state.currentPageIndex),
                  onForwardPressed: () => pageRightPressed(state),
                  currentIndex: state.currentPageIndex,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void clearAllFocuses() {
    _manufacturerFocusNode.unfocus();
    _modelFocusNode.unfocus();
    _yearFocusNode.unfocus();
    _colorFocusNode.unfocus();
    _priceFocusNode.unfocus();
  }

  void pageLeftPressed(int currentIndex) {
    final cubit = context.read<NewItemPageCubit>();
    clearAllFocuses();

    if (currentIndex < 1) return;

    cubit.updateTabIndex(currentIndex - 1);

    _pageViewController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void pageRightPressed(NewItemPageState state) {
    final currentIndex = state.currentPageIndex;
    final isLastIndex = currentIndex == ItemSetupTab.pickers.index;

    if (isLastIndex) {
      final cubit = context.read<NewItemPageCubit>();
      final isEngineVolumeValid = cubit.validateEngineVolume(cubit.state.engineVolumeText, false);
      if (!isEngineVolumeValid) return;

      final updatedCars = cubit.insertItem();
      context.read<ExplorePageCubit>().updateCars(updatedCars);
      context.go(AppRoutes.home, extra: HomePageParams(isFromSetup: true));
      return;
    }

    final cubit = context.read<NewItemPageCubit>();

    if (currentIndex == ItemSetupTab.infoForm.index) {
      final areAllFieldsValid = cubit.areAllFieldsValid();

      if (!areAllFieldsValid) return;
    }

    _pageViewController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    cubit.updateTabIndex(currentIndex + 1);

    clearAllFocuses();
  }
}
