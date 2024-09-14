import '../../domain/entity/customer/customer.dart';
import '../../model/customer/customer_response.dart';
import 'base_data_mapper.dart';

class CustomerDataMapper extends BaseDataMapper<CustomerResponse, Customer> {
  @override
  Customer mapToEntity(CustomerResponse? data) {
    return Customer(
        id: data?.id,
        routeId: data?.routeId,
        fullname: data?.fullname,
        dateOfBirth: data?.dateOfBirth,
        mobile: data?.mobile,
        address: data?.address,
        district: data?.district,
        province: data?.province,
        commune: data?.commune,
        agency: data?.agency,
        customerType: data?.customerType,
        taxCode: data?.taxCode,
        contactPerson: data?.contactPerson,
        position: data?.position,
        foundation: data?.foundation,
        timeCheckinRecent: data?.timeCheckinRecent,
        totalCheckin: data?.totalCheckin,
        totalOrder: data?.totalOrder);
  }
}
