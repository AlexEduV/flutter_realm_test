import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter_project/common/constants/app_colors.dart';
import 'package:test_flutter_project/common/constants/app_routes.dart';
import 'package:test_flutter_project/common/constants/app_text_styles.dart';
import 'package:test_flutter_project/common/enums/body_type.dart';
import 'package:test_flutter_project/common/enums/fuel_type.dart';
import 'package:test_flutter_project/common/enums/item_setup_tab.dart';
import 'package:test_flutter_project/common/enums/transmission_type.dart';
import 'package:test_flutter_project/common/extensions/context_extension.dart';
import 'package:test_flutter_project/common/extensions/string_extension.dart';
import 'package:test_flutter_project/l10n/l10n_keys.dart';
import 'package:test_flutter_project/presentation/bloc/home/new_item_page/new_item_page_cubit.dart';
import 'package:test_flutter_project/presentation/bloc/home/new_item_page/new_item_page_state.dart';
import 'package:test_flutter_project/presentation/bloc/user/user_data_cubit.dart';
import 'package:test_flutter_project/presentation/pages/home/new_item_page/sub_pages/car_type_picker.dart';
import 'package:test_flutter_project/presentation/pages/home/new_item_page/sub_pages/item_info_form.dart';
import 'package:test_flutter_project/presentation/pages/home/new_item_page/sub_pages/item_specs_picker.dart';
import 'package:test_flutter_project/presentation/pages/home/new_item_page/widgets/page_selection_bar.dart';

import '../../../../common/constants/app_dimensions.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../domain/entities/car_entity.dart';
import '../../../../domain/entities/owner_entity.dart';
import '../../../../domain/usecases/database/add_car_use_case.dart';
import '../../../../domain/usecases/database/get_all_cars_use_case.dart';
import '../../../../domain/usecases/database/get_current_max_car_id_use_case.dart';
import '../../../bloc/home/explore_page/explore_page_cubit.dart';

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
  final priceFocusNode = FocusNode();

  BodyType? selectedBodyType = BodyType.sedan;
  TransmissionType? selectedTransmissionType = TransmissionType.manual;
  FuelType? selectedFuelType = FuelType.diesel;

  @override
  void initState() {
    super.initState();

    final initIndex = ItemSetupTab.type.index;

    final cubit = context.read<NewItemPageCubit>();
    cubit.updateTabIndex(initIndex);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageViewController.jumpToPage(initIndex);
    });

    cubit.clearInfoForm();
  }

  @override
  void dispose() {
    manufacturerFocusNode.dispose();
    modelFocusNode.dispose();
    yearFocusNode.dispose();
    priceFocusNode.dispose();
    colorFocusNode.dispose();

    pageViewController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.tr(L10nKeys.addNewItemPageTitle), style: AppTextStyles.zonaPro20),
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
                    controller: pageViewController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const CarTypePicker(),

                      ItemInfoForm(
                        manufacturerFocusNode: manufacturerFocusNode,
                        modelFocusNode: modelFocusNode,
                        colorFocusNode: colorFocusNode,
                        yearFocusNode: yearFocusNode,
                        priceFocusNode: priceFocusNode,
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
    manufacturerFocusNode.unfocus();
    modelFocusNode.unfocus();
    yearFocusNode.unfocus();
    colorFocusNode.unfocus();
    priceFocusNode.unfocus();
  }

  void pageLeftPressed(int currentIndex) {
    final cubit = context.read<NewItemPageCubit>();
    clearAllFocuses();

    if (currentIndex < 1) return;

    cubit.updateTabIndex(currentIndex - 1);

    pageViewController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void pageRightPressed(NewItemPageState state) {
    final currentIndex = state.currentPageIndex;
    final isLastIndex = currentIndex == ItemSetupTab.pickers.index;

    if (isLastIndex) {
      insertItem(state);
      return;
    }

    final cubit = context.read<NewItemPageCubit>();

    if (currentIndex == ItemSetupTab.infoForm.index) {
      final areAllFieldsValid = cubit.areAllFieldsValid();

      if (!areAllFieldsValid) return;
    }

    pageViewController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    cubit.updateTabIndex(currentIndex + 1);

    clearAllFocuses();
  }

  void insertItem(NewItemPageState state) {
    final userDataCubit = context.read<UserDataCubit>();

    final currentMaxCarId = serviceLocator<GetCurrentMaxCarIdUseCase>().call();
    final newCarId = (currentMaxCarId + 1).toString();

    userDataCubit.addCarIdToCreated(newCarId);

    final currentCars = serviceLocator<GetAllCarsUseCase>().call();

    final car = CarEntity(
      carId: newCarId,
      model: state.modelText.capitalizeFirst(),
      manufacturer: state.manufacturerText.capitalizeFirst(),
      isVerified: false,
      type: state.selectedCarType.name,
      bodyType: state.selectedBodyType?.name ?? '',
      fuelType: state.selectedFuelType.name,
      transmissionType: state.selectedTransmissionType.name,
      color: state.colorText.capitalizeFirst(),
      owner: OwnerEntity.fromUser(userDataCubit.user),
      price: int.tryParse(state.priceText) ?? 0,
      year: state.yearText,
    );

    serviceLocator<AddCarUseCase>().call(car);

    context.read<ExplorePageCubit>().updateCars(currentCars..add(car));

    context.go(AppRoutes.home, extra: {'fromSetup': true});
  }
}
