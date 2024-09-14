import '../../domain/entity/appointment/appointment_entity.dart';
import '../../domain/entity/appointment/calendar_event.dart';
import '../../domain/entity/appointment/event_entity.dart';
import '../../model/appointment/appointment_response.dart';
import '../../model/appointment/calendar_event_response.dart';
import '../../model/appointment/event_response.dart';
import '../constants.dart';
import 'base_data_mapper.dart';

class AppointmentDataMapper
    extends BaseDataMapper<AppointmentResponse, AppointmentEntity>
    with DataMapperMixin {
  @override
  AppointmentEntity mapToEntity(AppointmentResponse? data) {
    return AppointmentEntity(
        id: data?.id,
        routeId: data?.routeId,
        customerId: data?.customerId,
        customerName: data?.customerName,
        customerPhone: data?.customerPhone,
        address: data?.address,
        employeeName: data?.employeeName,
        employeeUserName: data?.employeeUserName,
        position: data?.position,
        dateAppointment: data?.dateAppointment,
        location: data?.location,
        district: data?.district,
        province: data?.province,
        ward: data?.ward,
        purpose: data?.purpose,
        note: data?.note,
        status: data?.status,
        type: data?.type,
        longitude: data?.longitude,
        latitude: data?.latitude,
        code: data?.code);
  }

  @override
  AppointmentResponse mapToData(AppointmentEntity entity) {
    return AppointmentResponse(
        id: entity.id,
        routeId: entity.routeId,
        customerId: entity.customerId,
        customerName: entity.customerName,
        customerPhone: entity.customerPhone,
        address: entity.address,
        employeeName: entity.employeeName,
        employeeUserName: entity.employeeUserName,
        position: entity.position,
        dateAppointment: entity.dateAppointment,
        location: entity.location,
        district: entity.district,
        province: entity.province,
        ward: entity.ward,
        purpose: entity.purpose,
        note: entity.note,
        status: entity.status,
        type: entity.type,
        longitude: entity.longitude,
        latitude: entity.latitude,
        code: entity.code);
  }
}

class CalendarEventDataMapper
    extends BaseDataMapper<CalendarEventResponse, CalendarEvent> {
  @override
  CalendarEvent mapToEntity(CalendarEventResponse? data) {
    return CalendarEvent(
        listAppointment: data?.listAppointment,
        listDateOfBirth: data?.listDateOfBirth,
        listEvent: data?.listEvent);
  }
}

class EventDataMapper extends BaseDataMapper<EventResponse, EventEntity> {
  @override
  EventEntity mapToEntity(EventResponse? data) {
    return EventEntity(
        id: data?.id,
        title: data?.title,
        status: data?.status,
        date: data?.date,
        startTime: data?.startTime,
        endTime: data?.endTime,
        limitGuests: data?.limitGuests,
        location: data?.location,
        district: data?.district,
        banner: data?.banner,
        description: data?.description,
        note: data?.note,
        eventType: data?.eventType,
        startDate: data?.startDate,
        endDate: data?.endDate,
        eventID: data?.eventID,
        guest: data?.guest,
        city: data?.city,
        picture: data?.picture,
        statusRegister: data?.statusRegister,
        statusRegisterStr:
            data?.statusRegister == EventRegisterStatus.noResponse
                ? EventRegisterStatusString.noResponse
                : data?.statusRegister == EventRegisterStatus.refuse
                    ? EventRegisterStatusString.refuse
                    : data?.statusRegister == EventRegisterStatus.willJoin
                        ? EventRegisterStatusString.willJoin
                        : EventRegisterStatusString.interested,
        region: data?.region,
        state: data?.state,
        town: data?.town);
  }
}
