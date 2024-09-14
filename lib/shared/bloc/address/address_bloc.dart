import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/public_api/location.dart';
import '../../../data/repository/remote/utility_repository.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final UtilityRepository utilityRepository;

  var _currentProvinceSelectedId = '';
  var _currentDistrictSelectedId = '';
  var _currentWardSelectedId = '';
  final List<Province> _provinceList = [];
  final List<District> _districtList = [];
  final List<District> _allDistrictList = [];
  final List<Ward> _wardsList = [];
  final List<Ward> _allWardsList = [];

  AddressBloc({required this.utilityRepository}) : super(AddressInitial()) {
    on<AddressGetAllEvent>(_onGetAll);
    on<AddressGetProvinceListEvent>(_onGetProvince);
    on<AddressGetDistrictListEvent>(_onGetDistrict);
    on<AddressGetWardListEvent>(_onGetWard);
    on<AddressHandleSelectedEvent>(_onHandleChosen);
  }

  FutureOr<void> _onGetProvince(
      AddressGetProvinceListEvent event, Emitter<AddressState> emit) async {
    // get current address information
    if ((event.initialProvince ?? '').isNotEmpty && _provinceList.isNotEmpty) {
      try {
        _currentProvinceSelectedId = _provinceList
            .where((element) => element.value == event.initialProvince)
            .first
            .value!;

        if (_currentProvinceSelectedId != '') {
          // get district

          _districtList.clear();
          _districtList.addAll(_allDistrictList.where(
              (element) => element.parent == _currentProvinceSelectedId));
          try {
            _currentDistrictSelectedId = _allDistrictList
                .where((element) => element.value == event.initialDistrict)
                .first
                .value!;
          } catch (e) {
            _currentDistrictSelectedId = '';
          }

          // get ward
          if (_currentDistrictSelectedId != '') {
            _wardsList.clear();
            _wardsList.addAll(_allWardsList.where(
                (element) => element.parent == _currentDistrictSelectedId));
            // emit something to notify ui that data is loaded
          }
        }

        // newCustomerBloc.add(GetDistrictListEvent(
        //     provinceId: _currentProvinceSelectedId));
        // ignore: empty_catches
      } catch (e) {}
    }
  }

  FutureOr<void> _onGetDistrict(
      AddressGetDistrictListEvent event, Emitter<AddressState> emit) async {
    _districtList.clear();
    _districtList.addAll(_allDistrictList
        .where((element) => element.parent == _currentProvinceSelectedId));
  }

  FutureOr<void> _onGetWard(
      AddressGetWardListEvent event, Emitter<AddressState> emit) async {
    _wardsList.clear();
    _wardsList.addAll(_allWardsList
        .where((element) => element.parent == _currentDistrictSelectedId));
  }

  set currentProvinceSelectedId(value) {
    _currentProvinceSelectedId = value;
  }

  String get currentProvinceSelectedId => _currentProvinceSelectedId;

  set currentDistrictSelectedId(value) {
    _currentDistrictSelectedId = value;
  }

  String get currentDistrictSelectedId => _currentDistrictSelectedId;

  // set provinceList(value) {
  //   _provinceList = value;
  // }

  List<Province> get provinceList => _provinceList;

  // set districtList(value) {
  //   _districtList = value;
  // }

  List<District> get districtList => _districtList;

  // set wardsList(value) {
  //   _wardsList = value;
  // }

  List<Ward> get wardsList => _wardsList;

  FutureOr<void> _onHandleChosen(
      AddressHandleSelectedEvent event, Emitter<AddressState> emit) {
    if (event.selected == null) {
      return null;
    }

    if (event.selected is Province) {
      final Province provinceSelected = event.selected;
      if (provinceSelected.value == _currentProvinceSelectedId) {
        return null;
      }
      _currentProvinceSelectedId = provinceSelected.value!;
      _districtList.clear();
      _wardsList.clear();
      _currentDistrictSelectedId = '';
      emit(AddressSelectProvince(provinceName: provinceSelected.value ?? ''));
    }

    if (event.selected is District) {
      final District districtSelected = event.selected;
      if (districtSelected.value == _currentDistrictSelectedId) {
        return null;
      }
      _currentDistrictSelectedId = districtSelected.value ?? '';
      _currentWardSelectedId = '';
      wardsList.clear();
      emit(AddressSelectDistrict(districtName: districtSelected.value ?? ''));
    }

    if (event.selected is Ward) {
      final Ward wardSelected = event.selected;
      if (wardSelected.value == _currentWardSelectedId) {
        return null;
      }
      _currentWardSelectedId = wardSelected.value ?? '';
      emit(AddressSelectWard(wardName: wardSelected.value ?? ''));
    }
  }

  FutureOr<void> _onGetAll(
      AddressGetAllEvent event, Emitter<AddressState> emit) async {
    final pResponse = await utilityRepository.getProvincesList();
    final dResponse = await utilityRepository.getDistrictsList();
    final wResponse = await utilityRepository.getCommunesList();
    _provinceList.addAll(pResponse.data!);
    _allDistrictList.addAll(dResponse.data!);
    _allWardsList.addAll(wResponse.data!);

    emit(AddressGetAllSuccessState());
  }
}
