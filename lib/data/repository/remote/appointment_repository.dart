import '../../../domain/entity/appointment/appointment_entity.dart';
import '../../../domain/entity/appointment/calendar_event.dart';
import '../../../model/api/base_response.dart';

abstract class AppointmentRepository {
  Future<ResponseWrapper<AppointmentEntity>> addAppointment(AppointmentEntity appointment);

  Future<ResponseWrapper<AppointmentEntity>> editAppointment(AppointmentEntity appointment);

  Future<ResponseWrapper<CalendarEvent>> getCalendarDayEvent(DateTime date);

  Future<ResponseWrapper<Map<String, List<String>>>> getCalendarEvent(int month, int year, {int? day});
}
