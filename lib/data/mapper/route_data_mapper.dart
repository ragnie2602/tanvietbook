import '../../model/route.dart';
import '../../model/route/route_response.dart';
import 'base_data_mapper.dart';

class RouteDataMapper extends BaseDataMapper<RouteResponse, RouteEntity> {
  @override
  RouteEntity mapToEntity(RouteResponse? data) {
    return RouteEntity(
        error: data?.error, code: data?.code, id: data?.id, name: data?.name);
  }
}
