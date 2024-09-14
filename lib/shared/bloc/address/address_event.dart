part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object?> get props => [];
}

class AddressGetAllEvent extends AddressEvent {
  final String? initialProvince;
  final String? initialDistrict;

  const AddressGetAllEvent({this.initialProvince, this.initialDistrict});
}

class AddressGetProvinceListEvent extends AddressEvent {
  final String? initialProvince;
  final String? initialDistrict;

  const AddressGetProvinceListEvent(
      {this.initialProvince, this.initialDistrict});
}

class AddressGetDistrictListEvent extends AddressEvent {}

class AddressGetWardListEvent extends AddressEvent {}

class AddressHandleSelectedEvent extends AddressEvent {
  final dynamic selected;

  const AddressHandleSelectedEvent({this.selected});
}
