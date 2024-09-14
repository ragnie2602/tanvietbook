import '../../domain/entity/appointment/appointment_entity.dart';
import '../../domain/entity/appointment/event_entity.dart';

class CalendarEventResponse {
  List<EventEntity>? listEvent;
  List<String>? listDateOfBirth;
  List<AppointmentEntity>? listAppointment;

  CalendarEventResponse({this.listEvent, this.listDateOfBirth, this.listAppointment});

  CalendarEventResponse.fromJson(Map<String, dynamic> json) {
    if (json['listEvent'] != null) {
      listEvent = <EventEntity>[];
      json['listEvent'].forEach((v) {
        listEvent!.add(EventEntity.fromJson(v));
      });
    }
    listDateOfBirth = (json['listDateOfBirth'] ?? []).cast<String>();
    if (json['listAppointment'] != null) {
      listAppointment = <AppointmentEntity>[];
      json['listAppointment'].forEach((v) {
        listAppointment!.add(AppointmentEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (listEvent != null) {
      data['listEvent'] = listEvent!.map((v) => v.toJson()).toList();
    }
    data['listDateOfBirth'] = listDateOfBirth;
    if (listAppointment != null) {
      data['listAppointment'] = listAppointment!.map((e) => e.toJson()).toList();
    }
    return data;
  }
}
