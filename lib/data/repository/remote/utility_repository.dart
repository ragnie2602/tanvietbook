import '../../../model/api/base_response.dart';
import '../../model/public_api/location.dart';

abstract class UtilityRepository {
  Future<ResponseWrapper<List<Province>>> getProvincesList();

  Future<ResponseWrapper<List<District>>> getDistrictsList();

  Future<ResponseWrapper<List<Ward>>> getCommunesList();
}
