// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_page_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchPageState {
  List<CarEntity> get results;
  List<CarEntity> get allResults;
  CarType get currentSelectedType;
  bool get isLoading;
  Map<String, List<String>> get allModels;
  Map<String, List<String>> get selectedModels;
  String? get selectedMinYear;
  String? get selectedMaxYear;
  List<String> get allColors;
  List<String> get selectedColors;
  String? get minYearError;
  String? get maxYearError;
  List<String> get selectedBodyTypes;
  String? get selectedMinPrice;
  String? get selectedMaxPrice;
  String? get minPriceError;
  String? get maxPriceError;
  FieldParamsModel? get minYearFieldParamsModel;
  FieldParamsModel? get maxYearFieldParamsModel;
  FieldParamsModel? get minPriceFieldParamsModel;
  FieldParamsModel? get maxPriceFieldParamsModel;
  List<String> get selectedFuelTypes;
  List<String> get selectedTransmissionTypes;
  SearchDrawerType get drawerOpened;

  /// Create a copy of SearchPageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SearchPageStateCopyWith<SearchPageState> get copyWith =>
      _$SearchPageStateCopyWithImpl<SearchPageState>(
          this as SearchPageState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearchPageState &&
            const DeepCollectionEquality().equals(other.results, results) &&
            const DeepCollectionEquality()
                .equals(other.allResults, allResults) &&
            (identical(other.currentSelectedType, currentSelectedType) ||
                other.currentSelectedType == currentSelectedType) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality().equals(other.allModels, allModels) &&
            const DeepCollectionEquality()
                .equals(other.selectedModels, selectedModels) &&
            (identical(other.selectedMinYear, selectedMinYear) ||
                other.selectedMinYear == selectedMinYear) &&
            (identical(other.selectedMaxYear, selectedMaxYear) ||
                other.selectedMaxYear == selectedMaxYear) &&
            const DeepCollectionEquality().equals(other.allColors, allColors) &&
            const DeepCollectionEquality()
                .equals(other.selectedColors, selectedColors) &&
            (identical(other.minYearError, minYearError) ||
                other.minYearError == minYearError) &&
            (identical(other.maxYearError, maxYearError) ||
                other.maxYearError == maxYearError) &&
            const DeepCollectionEquality()
                .equals(other.selectedBodyTypes, selectedBodyTypes) &&
            (identical(other.selectedMinPrice, selectedMinPrice) ||
                other.selectedMinPrice == selectedMinPrice) &&
            (identical(other.selectedMaxPrice, selectedMaxPrice) ||
                other.selectedMaxPrice == selectedMaxPrice) &&
            (identical(other.minPriceError, minPriceError) ||
                other.minPriceError == minPriceError) &&
            (identical(other.maxPriceError, maxPriceError) ||
                other.maxPriceError == maxPriceError) &&
            (identical(
                    other.minYearFieldParamsModel, minYearFieldParamsModel) ||
                other.minYearFieldParamsModel == minYearFieldParamsModel) &&
            (identical(
                    other.maxYearFieldParamsModel, maxYearFieldParamsModel) ||
                other.maxYearFieldParamsModel == maxYearFieldParamsModel) &&
            (identical(
                    other.minPriceFieldParamsModel, minPriceFieldParamsModel) ||
                other.minPriceFieldParamsModel == minPriceFieldParamsModel) &&
            (identical(
                    other.maxPriceFieldParamsModel, maxPriceFieldParamsModel) ||
                other.maxPriceFieldParamsModel == maxPriceFieldParamsModel) &&
            const DeepCollectionEquality()
                .equals(other.selectedFuelTypes, selectedFuelTypes) &&
            const DeepCollectionEquality().equals(
                other.selectedTransmissionTypes, selectedTransmissionTypes) &&
            (identical(other.drawerOpened, drawerOpened) ||
                other.drawerOpened == drawerOpened));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(results),
        const DeepCollectionEquality().hash(allResults),
        currentSelectedType,
        isLoading,
        const DeepCollectionEquality().hash(allModels),
        const DeepCollectionEquality().hash(selectedModels),
        selectedMinYear,
        selectedMaxYear,
        const DeepCollectionEquality().hash(allColors),
        const DeepCollectionEquality().hash(selectedColors),
        minYearError,
        maxYearError,
        const DeepCollectionEquality().hash(selectedBodyTypes),
        selectedMinPrice,
        selectedMaxPrice,
        minPriceError,
        maxPriceError,
        minYearFieldParamsModel,
        maxYearFieldParamsModel,
        minPriceFieldParamsModel,
        maxPriceFieldParamsModel,
        const DeepCollectionEquality().hash(selectedFuelTypes),
        const DeepCollectionEquality().hash(selectedTransmissionTypes),
        drawerOpened
      ]);

  @override
  String toString() {
    return 'SearchPageState(results: $results, allResults: $allResults, currentSelectedType: $currentSelectedType, isLoading: $isLoading, allModels: $allModels, selectedModels: $selectedModels, selectedMinYear: $selectedMinYear, selectedMaxYear: $selectedMaxYear, allColors: $allColors, selectedColors: $selectedColors, minYearError: $minYearError, maxYearError: $maxYearError, selectedBodyTypes: $selectedBodyTypes, selectedMinPrice: $selectedMinPrice, selectedMaxPrice: $selectedMaxPrice, minPriceError: $minPriceError, maxPriceError: $maxPriceError, minYearFieldParamsModel: $minYearFieldParamsModel, maxYearFieldParamsModel: $maxYearFieldParamsModel, minPriceFieldParamsModel: $minPriceFieldParamsModel, maxPriceFieldParamsModel: $maxPriceFieldParamsModel, selectedFuelTypes: $selectedFuelTypes, selectedTransmissionTypes: $selectedTransmissionTypes, drawerOpened: $drawerOpened)';
  }
}

/// @nodoc
abstract mixin class $SearchPageStateCopyWith<$Res> {
  factory $SearchPageStateCopyWith(
          SearchPageState value, $Res Function(SearchPageState) _then) =
      _$SearchPageStateCopyWithImpl;
  @useResult
  $Res call(
      {List<CarEntity> results,
      List<CarEntity> allResults,
      CarType currentSelectedType,
      bool isLoading,
      Map<String, List<String>> allModels,
      Map<String, List<String>> selectedModels,
      String? selectedMinYear,
      String? selectedMaxYear,
      List<String> allColors,
      List<String> selectedColors,
      String? minYearError,
      String? maxYearError,
      List<String> selectedBodyTypes,
      String? selectedMinPrice,
      String? selectedMaxPrice,
      String? minPriceError,
      String? maxPriceError,
      FieldParamsModel? minYearFieldParamsModel,
      FieldParamsModel? maxYearFieldParamsModel,
      FieldParamsModel? minPriceFieldParamsModel,
      FieldParamsModel? maxPriceFieldParamsModel,
      List<String> selectedFuelTypes,
      List<String> selectedTransmissionTypes,
      SearchDrawerType drawerOpened});
}

/// @nodoc
class _$SearchPageStateCopyWithImpl<$Res>
    implements $SearchPageStateCopyWith<$Res> {
  _$SearchPageStateCopyWithImpl(this._self, this._then);

  final SearchPageState _self;
  final $Res Function(SearchPageState) _then;

  /// Create a copy of SearchPageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? allResults = null,
    Object? currentSelectedType = null,
    Object? isLoading = null,
    Object? allModels = null,
    Object? selectedModels = null,
    Object? selectedMinYear = freezed,
    Object? selectedMaxYear = freezed,
    Object? allColors = null,
    Object? selectedColors = null,
    Object? minYearError = freezed,
    Object? maxYearError = freezed,
    Object? selectedBodyTypes = null,
    Object? selectedMinPrice = freezed,
    Object? selectedMaxPrice = freezed,
    Object? minPriceError = freezed,
    Object? maxPriceError = freezed,
    Object? minYearFieldParamsModel = freezed,
    Object? maxYearFieldParamsModel = freezed,
    Object? minPriceFieldParamsModel = freezed,
    Object? maxPriceFieldParamsModel = freezed,
    Object? selectedFuelTypes = null,
    Object? selectedTransmissionTypes = null,
    Object? drawerOpened = null,
  }) {
    return _then(_self.copyWith(
      results: null == results
          ? _self.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<CarEntity>,
      allResults: null == allResults
          ? _self.allResults
          : allResults // ignore: cast_nullable_to_non_nullable
              as List<CarEntity>,
      currentSelectedType: null == currentSelectedType
          ? _self.currentSelectedType
          : currentSelectedType // ignore: cast_nullable_to_non_nullable
              as CarType,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      allModels: null == allModels
          ? _self.allModels
          : allModels // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      selectedModels: null == selectedModels
          ? _self.selectedModels
          : selectedModels // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      selectedMinYear: freezed == selectedMinYear
          ? _self.selectedMinYear
          : selectedMinYear // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedMaxYear: freezed == selectedMaxYear
          ? _self.selectedMaxYear
          : selectedMaxYear // ignore: cast_nullable_to_non_nullable
              as String?,
      allColors: null == allColors
          ? _self.allColors
          : allColors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedColors: null == selectedColors
          ? _self.selectedColors
          : selectedColors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      minYearError: freezed == minYearError
          ? _self.minYearError
          : minYearError // ignore: cast_nullable_to_non_nullable
              as String?,
      maxYearError: freezed == maxYearError
          ? _self.maxYearError
          : maxYearError // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedBodyTypes: null == selectedBodyTypes
          ? _self.selectedBodyTypes
          : selectedBodyTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedMinPrice: freezed == selectedMinPrice
          ? _self.selectedMinPrice
          : selectedMinPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedMaxPrice: freezed == selectedMaxPrice
          ? _self.selectedMaxPrice
          : selectedMaxPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      minPriceError: freezed == minPriceError
          ? _self.minPriceError
          : minPriceError // ignore: cast_nullable_to_non_nullable
              as String?,
      maxPriceError: freezed == maxPriceError
          ? _self.maxPriceError
          : maxPriceError // ignore: cast_nullable_to_non_nullable
              as String?,
      minYearFieldParamsModel: freezed == minYearFieldParamsModel
          ? _self.minYearFieldParamsModel
          : minYearFieldParamsModel // ignore: cast_nullable_to_non_nullable
              as FieldParamsModel?,
      maxYearFieldParamsModel: freezed == maxYearFieldParamsModel
          ? _self.maxYearFieldParamsModel
          : maxYearFieldParamsModel // ignore: cast_nullable_to_non_nullable
              as FieldParamsModel?,
      minPriceFieldParamsModel: freezed == minPriceFieldParamsModel
          ? _self.minPriceFieldParamsModel
          : minPriceFieldParamsModel // ignore: cast_nullable_to_non_nullable
              as FieldParamsModel?,
      maxPriceFieldParamsModel: freezed == maxPriceFieldParamsModel
          ? _self.maxPriceFieldParamsModel
          : maxPriceFieldParamsModel // ignore: cast_nullable_to_non_nullable
              as FieldParamsModel?,
      selectedFuelTypes: null == selectedFuelTypes
          ? _self.selectedFuelTypes
          : selectedFuelTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedTransmissionTypes: null == selectedTransmissionTypes
          ? _self.selectedTransmissionTypes
          : selectedTransmissionTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      drawerOpened: null == drawerOpened
          ? _self.drawerOpened
          : drawerOpened // ignore: cast_nullable_to_non_nullable
              as SearchDrawerType,
    ));
  }
}

/// @nodoc

class _SearchPageState implements SearchPageState {
  const _SearchPageState(
      {final List<CarEntity> results = const [],
      final List<CarEntity> allResults = const [],
      this.currentSelectedType = CarType.car,
      this.isLoading = false,
      final Map<String, List<String>> allModels = const {},
      final Map<String, List<String>> selectedModels = const {},
      this.selectedMinYear,
      this.selectedMaxYear,
      final List<String> allColors = const [],
      final List<String> selectedColors = const [],
      this.minYearError,
      this.maxYearError,
      final List<String> selectedBodyTypes = const [],
      this.selectedMinPrice,
      this.selectedMaxPrice,
      this.minPriceError,
      this.maxPriceError,
      this.minYearFieldParamsModel,
      this.maxYearFieldParamsModel,
      this.minPriceFieldParamsModel,
      this.maxPriceFieldParamsModel,
      final List<String> selectedFuelTypes = const [],
      final List<String> selectedTransmissionTypes = const [],
      this.drawerOpened = SearchDrawerType.empty})
      : _results = results,
        _allResults = allResults,
        _allModels = allModels,
        _selectedModels = selectedModels,
        _allColors = allColors,
        _selectedColors = selectedColors,
        _selectedBodyTypes = selectedBodyTypes,
        _selectedFuelTypes = selectedFuelTypes,
        _selectedTransmissionTypes = selectedTransmissionTypes;

  final List<CarEntity> _results;
  @override
  @JsonKey()
  List<CarEntity> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  final List<CarEntity> _allResults;
  @override
  @JsonKey()
  List<CarEntity> get allResults {
    if (_allResults is EqualUnmodifiableListView) return _allResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allResults);
  }

  @override
  @JsonKey()
  final CarType currentSelectedType;
  @override
  @JsonKey()
  final bool isLoading;
  final Map<String, List<String>> _allModels;
  @override
  @JsonKey()
  Map<String, List<String>> get allModels {
    if (_allModels is EqualUnmodifiableMapView) return _allModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_allModels);
  }

  final Map<String, List<String>> _selectedModels;
  @override
  @JsonKey()
  Map<String, List<String>> get selectedModels {
    if (_selectedModels is EqualUnmodifiableMapView) return _selectedModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_selectedModels);
  }

  @override
  final String? selectedMinYear;
  @override
  final String? selectedMaxYear;
  final List<String> _allColors;
  @override
  @JsonKey()
  List<String> get allColors {
    if (_allColors is EqualUnmodifiableListView) return _allColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allColors);
  }

  final List<String> _selectedColors;
  @override
  @JsonKey()
  List<String> get selectedColors {
    if (_selectedColors is EqualUnmodifiableListView) return _selectedColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedColors);
  }

  @override
  final String? minYearError;
  @override
  final String? maxYearError;
  final List<String> _selectedBodyTypes;
  @override
  @JsonKey()
  List<String> get selectedBodyTypes {
    if (_selectedBodyTypes is EqualUnmodifiableListView)
      return _selectedBodyTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedBodyTypes);
  }

  @override
  final String? selectedMinPrice;
  @override
  final String? selectedMaxPrice;
  @override
  final String? minPriceError;
  @override
  final String? maxPriceError;
  @override
  final FieldParamsModel? minYearFieldParamsModel;
  @override
  final FieldParamsModel? maxYearFieldParamsModel;
  @override
  final FieldParamsModel? minPriceFieldParamsModel;
  @override
  final FieldParamsModel? maxPriceFieldParamsModel;
  final List<String> _selectedFuelTypes;
  @override
  @JsonKey()
  List<String> get selectedFuelTypes {
    if (_selectedFuelTypes is EqualUnmodifiableListView)
      return _selectedFuelTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedFuelTypes);
  }

  final List<String> _selectedTransmissionTypes;
  @override
  @JsonKey()
  List<String> get selectedTransmissionTypes {
    if (_selectedTransmissionTypes is EqualUnmodifiableListView)
      return _selectedTransmissionTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedTransmissionTypes);
  }

  @override
  @JsonKey()
  final SearchDrawerType drawerOpened;

  /// Create a copy of SearchPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchPageStateCopyWith<_SearchPageState> get copyWith =>
      __$SearchPageStateCopyWithImpl<_SearchPageState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchPageState &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            const DeepCollectionEquality()
                .equals(other._allResults, _allResults) &&
            (identical(other.currentSelectedType, currentSelectedType) ||
                other.currentSelectedType == currentSelectedType) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._allModels, _allModels) &&
            const DeepCollectionEquality()
                .equals(other._selectedModels, _selectedModels) &&
            (identical(other.selectedMinYear, selectedMinYear) ||
                other.selectedMinYear == selectedMinYear) &&
            (identical(other.selectedMaxYear, selectedMaxYear) ||
                other.selectedMaxYear == selectedMaxYear) &&
            const DeepCollectionEquality()
                .equals(other._allColors, _allColors) &&
            const DeepCollectionEquality()
                .equals(other._selectedColors, _selectedColors) &&
            (identical(other.minYearError, minYearError) ||
                other.minYearError == minYearError) &&
            (identical(other.maxYearError, maxYearError) ||
                other.maxYearError == maxYearError) &&
            const DeepCollectionEquality()
                .equals(other._selectedBodyTypes, _selectedBodyTypes) &&
            (identical(other.selectedMinPrice, selectedMinPrice) ||
                other.selectedMinPrice == selectedMinPrice) &&
            (identical(other.selectedMaxPrice, selectedMaxPrice) ||
                other.selectedMaxPrice == selectedMaxPrice) &&
            (identical(other.minPriceError, minPriceError) ||
                other.minPriceError == minPriceError) &&
            (identical(other.maxPriceError, maxPriceError) ||
                other.maxPriceError == maxPriceError) &&
            (identical(
                    other.minYearFieldParamsModel, minYearFieldParamsModel) ||
                other.minYearFieldParamsModel == minYearFieldParamsModel) &&
            (identical(
                    other.maxYearFieldParamsModel, maxYearFieldParamsModel) ||
                other.maxYearFieldParamsModel == maxYearFieldParamsModel) &&
            (identical(
                    other.minPriceFieldParamsModel, minPriceFieldParamsModel) ||
                other.minPriceFieldParamsModel == minPriceFieldParamsModel) &&
            (identical(
                    other.maxPriceFieldParamsModel, maxPriceFieldParamsModel) ||
                other.maxPriceFieldParamsModel == maxPriceFieldParamsModel) &&
            const DeepCollectionEquality()
                .equals(other._selectedFuelTypes, _selectedFuelTypes) &&
            const DeepCollectionEquality().equals(
                other._selectedTransmissionTypes, _selectedTransmissionTypes) &&
            (identical(other.drawerOpened, drawerOpened) ||
                other.drawerOpened == drawerOpened));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(_results),
        const DeepCollectionEquality().hash(_allResults),
        currentSelectedType,
        isLoading,
        const DeepCollectionEquality().hash(_allModels),
        const DeepCollectionEquality().hash(_selectedModels),
        selectedMinYear,
        selectedMaxYear,
        const DeepCollectionEquality().hash(_allColors),
        const DeepCollectionEquality().hash(_selectedColors),
        minYearError,
        maxYearError,
        const DeepCollectionEquality().hash(_selectedBodyTypes),
        selectedMinPrice,
        selectedMaxPrice,
        minPriceError,
        maxPriceError,
        minYearFieldParamsModel,
        maxYearFieldParamsModel,
        minPriceFieldParamsModel,
        maxPriceFieldParamsModel,
        const DeepCollectionEquality().hash(_selectedFuelTypes),
        const DeepCollectionEquality().hash(_selectedTransmissionTypes),
        drawerOpened
      ]);

  @override
  String toString() {
    return 'SearchPageState(results: $results, allResults: $allResults, currentSelectedType: $currentSelectedType, isLoading: $isLoading, allModels: $allModels, selectedModels: $selectedModels, selectedMinYear: $selectedMinYear, selectedMaxYear: $selectedMaxYear, allColors: $allColors, selectedColors: $selectedColors, minYearError: $minYearError, maxYearError: $maxYearError, selectedBodyTypes: $selectedBodyTypes, selectedMinPrice: $selectedMinPrice, selectedMaxPrice: $selectedMaxPrice, minPriceError: $minPriceError, maxPriceError: $maxPriceError, minYearFieldParamsModel: $minYearFieldParamsModel, maxYearFieldParamsModel: $maxYearFieldParamsModel, minPriceFieldParamsModel: $minPriceFieldParamsModel, maxPriceFieldParamsModel: $maxPriceFieldParamsModel, selectedFuelTypes: $selectedFuelTypes, selectedTransmissionTypes: $selectedTransmissionTypes, drawerOpened: $drawerOpened)';
  }
}

/// @nodoc
abstract mixin class _$SearchPageStateCopyWith<$Res>
    implements $SearchPageStateCopyWith<$Res> {
  factory _$SearchPageStateCopyWith(
          _SearchPageState value, $Res Function(_SearchPageState) _then) =
      __$SearchPageStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<CarEntity> results,
      List<CarEntity> allResults,
      CarType currentSelectedType,
      bool isLoading,
      Map<String, List<String>> allModels,
      Map<String, List<String>> selectedModels,
      String? selectedMinYear,
      String? selectedMaxYear,
      List<String> allColors,
      List<String> selectedColors,
      String? minYearError,
      String? maxYearError,
      List<String> selectedBodyTypes,
      String? selectedMinPrice,
      String? selectedMaxPrice,
      String? minPriceError,
      String? maxPriceError,
      FieldParamsModel? minYearFieldParamsModel,
      FieldParamsModel? maxYearFieldParamsModel,
      FieldParamsModel? minPriceFieldParamsModel,
      FieldParamsModel? maxPriceFieldParamsModel,
      List<String> selectedFuelTypes,
      List<String> selectedTransmissionTypes,
      SearchDrawerType drawerOpened});
}

/// @nodoc
class __$SearchPageStateCopyWithImpl<$Res>
    implements _$SearchPageStateCopyWith<$Res> {
  __$SearchPageStateCopyWithImpl(this._self, this._then);

  final _SearchPageState _self;
  final $Res Function(_SearchPageState) _then;

  /// Create a copy of SearchPageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? results = null,
    Object? allResults = null,
    Object? currentSelectedType = null,
    Object? isLoading = null,
    Object? allModels = null,
    Object? selectedModels = null,
    Object? selectedMinYear = freezed,
    Object? selectedMaxYear = freezed,
    Object? allColors = null,
    Object? selectedColors = null,
    Object? minYearError = freezed,
    Object? maxYearError = freezed,
    Object? selectedBodyTypes = null,
    Object? selectedMinPrice = freezed,
    Object? selectedMaxPrice = freezed,
    Object? minPriceError = freezed,
    Object? maxPriceError = freezed,
    Object? minYearFieldParamsModel = freezed,
    Object? maxYearFieldParamsModel = freezed,
    Object? minPriceFieldParamsModel = freezed,
    Object? maxPriceFieldParamsModel = freezed,
    Object? selectedFuelTypes = null,
    Object? selectedTransmissionTypes = null,
    Object? drawerOpened = null,
  }) {
    return _then(_SearchPageState(
      results: null == results
          ? _self._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<CarEntity>,
      allResults: null == allResults
          ? _self._allResults
          : allResults // ignore: cast_nullable_to_non_nullable
              as List<CarEntity>,
      currentSelectedType: null == currentSelectedType
          ? _self.currentSelectedType
          : currentSelectedType // ignore: cast_nullable_to_non_nullable
              as CarType,
      isLoading: null == isLoading
          ? _self.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      allModels: null == allModels
          ? _self._allModels
          : allModels // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      selectedModels: null == selectedModels
          ? _self._selectedModels
          : selectedModels // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      selectedMinYear: freezed == selectedMinYear
          ? _self.selectedMinYear
          : selectedMinYear // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedMaxYear: freezed == selectedMaxYear
          ? _self.selectedMaxYear
          : selectedMaxYear // ignore: cast_nullable_to_non_nullable
              as String?,
      allColors: null == allColors
          ? _self._allColors
          : allColors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedColors: null == selectedColors
          ? _self._selectedColors
          : selectedColors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      minYearError: freezed == minYearError
          ? _self.minYearError
          : minYearError // ignore: cast_nullable_to_non_nullable
              as String?,
      maxYearError: freezed == maxYearError
          ? _self.maxYearError
          : maxYearError // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedBodyTypes: null == selectedBodyTypes
          ? _self._selectedBodyTypes
          : selectedBodyTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedMinPrice: freezed == selectedMinPrice
          ? _self.selectedMinPrice
          : selectedMinPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedMaxPrice: freezed == selectedMaxPrice
          ? _self.selectedMaxPrice
          : selectedMaxPrice // ignore: cast_nullable_to_non_nullable
              as String?,
      minPriceError: freezed == minPriceError
          ? _self.minPriceError
          : minPriceError // ignore: cast_nullable_to_non_nullable
              as String?,
      maxPriceError: freezed == maxPriceError
          ? _self.maxPriceError
          : maxPriceError // ignore: cast_nullable_to_non_nullable
              as String?,
      minYearFieldParamsModel: freezed == minYearFieldParamsModel
          ? _self.minYearFieldParamsModel
          : minYearFieldParamsModel // ignore: cast_nullable_to_non_nullable
              as FieldParamsModel?,
      maxYearFieldParamsModel: freezed == maxYearFieldParamsModel
          ? _self.maxYearFieldParamsModel
          : maxYearFieldParamsModel // ignore: cast_nullable_to_non_nullable
              as FieldParamsModel?,
      minPriceFieldParamsModel: freezed == minPriceFieldParamsModel
          ? _self.minPriceFieldParamsModel
          : minPriceFieldParamsModel // ignore: cast_nullable_to_non_nullable
              as FieldParamsModel?,
      maxPriceFieldParamsModel: freezed == maxPriceFieldParamsModel
          ? _self.maxPriceFieldParamsModel
          : maxPriceFieldParamsModel // ignore: cast_nullable_to_non_nullable
              as FieldParamsModel?,
      selectedFuelTypes: null == selectedFuelTypes
          ? _self._selectedFuelTypes
          : selectedFuelTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      selectedTransmissionTypes: null == selectedTransmissionTypes
          ? _self._selectedTransmissionTypes
          : selectedTransmissionTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      drawerOpened: null == drawerOpened
          ? _self.drawerOpened
          : drawerOpened // ignore: cast_nullable_to_non_nullable
              as SearchDrawerType,
    ));
  }
}

// dart format on
