import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../config/config.dart';
import '../../../di/di.dart';
import '../../../domain/entity/appointment/appointment_entity.dart';
import '../../../domain/entity/appointment/calendar_event.dart';
import '../../../model/api/base_response.dart';
import '../../../model/appointment/appointment_response.dart';
import '../../../model/appointment/calendar_event_response.dart';
import '../../../model/route.dart';
import '../../../model/route/route_response.dart';
import '../../../services/exceptions/handle_exception.dart';
import '../../mapper/appointment_data_mapper.dart';
import '../../mapper/route_data_mapper.dart';
import '../interceptor/dio_base_options.dart';
import '../interceptor/interceptor.dart';
import '../local/local_data_access.dart';
import 'appointment_repository.dart';

class AppointmentRepositoryImpl implements AppointmentRepository {
  final Dio dio = getIt.get();
  final LocalDataAccess localDataAccess = getIt.get();
  String accessToken = '';

  AppointmentRepositoryImpl() {
    dio.interceptors.add(PrettyDioLogger(responseBody: true, requestBody: true, requestHeader: true));
    dio.interceptors.add(AppInterceptor().queueInterceptor(dio: dio));
    dio.options = DioBaseOptions(baseUrl: Environment.agencyBaseUrl).baseOption;
  }

  late final AppointmentDataMapper _appointmentDataMapper = getIt.get();
  late final CalendarEventDataMapper _calendarEventDataMapper = getIt.get();
  late final RouteDataMapper _routeDataMapper = getIt.get();

  @override
  Future<ResponseWrapper<AppointmentEntity>> addAppointment(AppointmentEntity appointment) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.post(EndPoints.addApppointment,
          data: _appointmentDataMapper.mapToData(appointment).toJson()
            ..removeWhere((key, value) => value == null)
            ..addEntries({'agency': AppConfig.agencyName, 'salerName': localDataAccess.getUserName()}.entries),
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: _appointmentDataMapper.mapToEntity(AppointmentResponse.fromJson(response.data)));
      }
      return ResponseWrapper.error(message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<AppointmentEntity>> editAppointment(AppointmentEntity appointment) async {
    accessToken = localDataAccess.getAccessToken();

    try {
      final response = await dio.post(EndPoints.editAppointment,
          data: _appointmentDataMapper.mapToData(appointment).toJson()
            ..removeWhere((key, value) => value == null)
            ..addEntries({'agency': AppConfig.agencyName, 'salerName': localDataAccess.getUserName()}.entries),
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: _appointmentDataMapper.mapToEntity(AppointmentResponse.fromJson(response.data)));
      }
      return ResponseWrapper.error(message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<CalendarEvent>> getCalendarDayEvent(DateTime date) async {
    accessToken = localDataAccess.getAccessToken();
    try {
      final response = await dio.post(EndPoints.calendarDayEvent,
          data: {
            "status": [2, 3],
            "userId": localDataAccess.getUserId(),
            "startDate": date.toIso8601String(),
            "endDate": date.add(const Duration(days: 1)).toIso8601String(),
            "agency": AppConfig.agencyName,
            "salerName": localDataAccess.getUserName(),
            "date": date.toIso8601String()
          },
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));

      if (response.statusCode == 200) {
        return ResponseWrapper.success(
            data: _calendarEventDataMapper.mapToEntity(CalendarEventResponse.fromJson(response.data)));
      }
      return ResponseWrapper.error(message: response.statusMessage, statusCode: response.statusCode);
    } catch (e) {
      handleException(e);
      return ResponseWrapper.error(message: '$e');
    }
  }

  @override
  Future<ResponseWrapper<Map<String, List<String>>>> getCalendarEvent(int month, int year, {int? day}) async {
    accessToken = localDataAccess.getAccessToken();
    List<RouteEntity> routes = [];

    try {
      final response = await dio.post(EndPoints.routes,
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
          data: {
            'agency': AppConfig.agencyName,
            'manager': localDataAccess.getUserName(),
            'page': 1,
            'pageSize': 999999
          });

      if (response.statusCode == 200) {
        routes = (response.data['data'] as List)
            .map((e) => _routeDataMapper.mapToEntity(RouteResponse.fromJson(e)))
            .toList();
      }
    } catch (e) {
      return ResponseWrapper.error(message: '$e');
    }

    if (routes.isNotEmpty) {
      try {
        final response = await dio.post(EndPoints.calendarEvent,
            data: {
              "userId": localDataAccess.getUserId(),
              "startDate": DateTime.utc(year, month, 1).toIso8601String(),
              "endDate": DateTime.utc(year, month + 1, 1).toIso8601String(),
              "agency": AppConfig.agencyName,
              "month": month,
              "year": year,
              "salerName": localDataAccess.getUserName(),
              "routeId": routes.map((e) => e.id).toList()
            },
            options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
        if (response.statusCode == 200) {
          return ResponseWrapper.success(
              data: (response.data as Map<String, dynamic>)
                  .map((key, value) => MapEntry(key, List<String>.from(value ?? []))));
        }
        return ResponseWrapper.error(message: response.statusMessage, statusCode: response.statusCode);
      } catch (e) {
        handleException(e);
        return ResponseWrapper.error(message: '$e');
      }
    }
    return ResponseWrapper.error(message: 'Không thể lấy được danh sách tuyến');
  }
}
