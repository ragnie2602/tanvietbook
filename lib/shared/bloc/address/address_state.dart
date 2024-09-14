part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();
  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class AddressGetAllSuccessState extends AddressState {}

class AddressGetProvinceState extends AddressState {
  final List<Province> provinceList;
  const AddressGetProvinceState({required this.provinceList});
  @override
  List<Object> get props => [provinceList];
}

class AddressGetDistrictState extends AddressState {
  final List<District> districtList;
  const AddressGetDistrictState({required this.districtList});
  @override
  List<Object> get props => [districtList];
}

class AddressGetWardState extends AddressState {
  final List<Ward> wardList;
  const AddressGetWardState({required this.wardList});
  @override
  List<Object> get props => [wardList];
}

class AddressSelectProvince extends AddressState {
  final String provinceName;

  const AddressSelectProvince({required this.provinceName});

  @override
  List<Object> get props => [provinceName];
}

class AddressSelectDistrict extends AddressState {
  final String districtName;

  const AddressSelectDistrict({required this.districtName});

  @override
  List<Object> get props => [districtName];
}

class AddressSelectWard extends AddressState {
  final String wardName;

  const AddressSelectWard({required this.wardName});

  @override
  List<Object> get props => [wardName];
}
