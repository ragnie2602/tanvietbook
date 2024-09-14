import '../../domain/entity/checkin/checkin_detail.dart';
import '../../domain/entity/checkin/purpose.dart';
import '../../model/checkin/checkin_detail_response.dart';
import '../../model/checkin/purpose.dart';
import 'base_data_mapper.dart';

class CheckinDetailDataMapper extends BaseDataMapper<CheckinDetailResponse, CheckinDetail> {
  @override
  CheckinDetail mapToEntity(CheckinDetailResponse? data) {
    return CheckinDetail(
        id: data?.id,
        routeId: data?.routeId,
        customerId: data?.customerId,
        locationCheckin: data?.locationCheckin,
        longitudeCheckin: data?.longitudeCheckin,
        latitudeCheckin: data?.latitudeCheckin,
        timeCheckin: data?.timeCheckin,
        locationCheckout: data?.locationCheckout,
        longitudeCheckout: data?.longitudeCheckout,
        latitudeCheckout: data?.latitudeCheckout,
        timeCheckout: data?.timeCheckout,
        purpose: data?.purpose,
        images: data?.images,
        note: data?.note,
        orderTotal: data?.orderTotal,
        customerName: data?.customerName,
        mobileCus: data?.mobileCus,
        addressCus: data?.addressCus,
        districtCus: data?.districtCus,
        provinceCus: data?.provinceCus,
        communeCus: data?.communeCus,
        agency: data?.agency,
        listOrderId: data?.listOrderId);
  }
}

class PurposeDataMapper extends BaseDataMapper<PurposeResponse, Purpose> {
  @override
  Purpose mapToEntity(PurposeResponse? data) {
    return Purpose(id: data?.id, name: data?.name, error: data?.error);
  }
}
