part of 'customer_cubit.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();
  @override
  List<Object?> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerAddCustomerSuccess extends CustomerState {
  final Customer customer;

  const CustomerAddCustomerSuccess(this.customer);
  @override
  List<Object?> get props => [];
}

class CustomerAddCustomerFailed extends CustomerState {}

class CustomerCheckinSuccess extends CustomerState {
  final String checkinId;

  const CustomerCheckinSuccess(this.checkinId);
  @override
  List<Object?> get props => [checkinId];
}

class CustomerCheckinFailed extends CustomerState {}

class CustomerCheckRoleSuccess extends CustomerState {
  final int role;

  const CustomerCheckRoleSuccess(this.role);
  @override
  List<Object?> get props => [role];
}

class CustomerCheckRoleFailed extends CustomerState {}

class CustomerCheckoutSuccess extends CustomerState {}

class CustomerCheckoutFailed extends CustomerState {}

class CustomerCreateOrderWhileCheckin extends CustomerState {
  final String orderId;

  const CustomerCreateOrderWhileCheckin(this.orderId);
  @override
  List<Object?> get props => [orderId];
}

class CustomerEditCustomerSuccess extends CustomerState {
  final Customer customer;

  const CustomerEditCustomerSuccess(this.customer);
  @override
  List<Object?> get props => [];
}

class CustomerEditCustomerFailed extends CustomerState {}

class CustomerGetAllDistrictSuccess extends CustomerState {
  final List<Map<String, String>> districts;

  const CustomerGetAllDistrictSuccess(this.districts);
  @override
  List<Object?> get props => [];
}

class CustomerGetAllDistrictFailed extends CustomerState {}

class CustomerGetAllProductsSuccess extends CustomerState {
  final List<AgencyProduct> products;

  const CustomerGetAllProductsSuccess(this.products);
  @override
  List<Object?> get props => [products];
}

class CustomerGetAllProductFailed extends CustomerState {}

class CustomerGetAllProvincesSuccess extends CustomerState {
  final List<Map<String, String>> provinces;

  const CustomerGetAllProvincesSuccess(this.provinces);
  @override
  List<Object?> get props => [provinces];
}

class CustomerGetAllProvincesFailed extends CustomerState {}

class CustomerGetAllPurposeSuccessState extends CustomerState {
  final List<Purpose> purposes;

  const CustomerGetAllPurposeSuccessState(this.purposes);
  @override
  List<Object?> get props => [purposes];
}

class CustomerGetAllPurposesFailedState extends CustomerState {}

class CustomerGetAllRoutesSuccessState extends CustomerState {
  final List<RouteEntity> routes;

  const CustomerGetAllRoutesSuccessState(this.routes);

  @override
  List<Object?> get props => [routes];
}

class CustomerGetAllRoutesFailedState extends CustomerState {}

class CustomerGetAllWardSuccess extends CustomerState {
  final List<Map<String, String>> wards;

  const CustomerGetAllWardSuccess(this.wards);
  @override
  List<Object?> get props => [];
}

class CustomerGetAllWardFailed extends CustomerState {}

class CustomerGetCheckinDetailSuccess extends CustomerState {
  final CheckinDetail? checkinDetail;

  const CustomerGetCheckinDetailSuccess(this.checkinDetail);
  @override
  List<Object?> get props => [checkinDetail];
}

class CustomerGetCheckinDetailFailed extends CustomerState {}

class CustomerGetCustomerSuccess extends CustomerState {
  final Customer customer;

  const CustomerGetCustomerSuccess(this.customer);
  @override
  List<Object?> get props => [customer];
}

class CustomerGetCustomerFailed extends CustomerState {}

class CustomerGetDistanceSuccess extends CustomerState {
  final double distance;

  const CustomerGetDistanceSuccess(this.distance);
  @override
  List<Object?> get props => [];
}

class CustomerGetDistanceFailed extends CustomerState {}

class CustomerGetJourneySuccess extends CustomerState {
  final List<CheckinDetail> checkinDetails;

  const CustomerGetJourneySuccess(this.checkinDetails);
  @override
  List<Object?> get props => [];
}

class CustomerGetJourneyFailed extends CustomerState {}

class CustomerSearchCustomerByRouteSuccess extends CustomerState {
  final List<Customer> customers;

  const CustomerSearchCustomerByRouteSuccess(this.customers);
  @override
  List<Object?> get props => [customers];
}

class CustomerSearchCustomerByRouteFailed extends CustomerState {}

class CustomerUpdateMoney extends CustomerState {
  final int amount;
  final int total;
  final int save;
  final AgencyProduct product;

  const CustomerUpdateMoney({required this.amount, required this.product, required this.save, required this.total});
  @override
  List<Object?> get props => [amount, product, save, total];
}

class CustomerUploadMediaFailed extends CustomerState {}
