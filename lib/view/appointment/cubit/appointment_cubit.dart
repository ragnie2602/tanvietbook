import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repository/remote/agency_repository.dart';
import '../../../data/repository/remote/appointment_repository.dart';
import '../../../di/di.dart';
import '../../../domain/entity/appointment/appointment_entity.dart';
import '../../../domain/entity/appointment/calendar_event.dart';
import '../../../model/api/base_response.dart';

part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepository appointmentRepository = getIt.get();
  final AgencyRepository agencyRepository = getIt.get();

  AppointmentCubit() : super(AppointmentInitial());

  addAppointment(AppointmentEntity appointment) async {
    emit(AppointmentLoading());

    final response = await appointmentRepository.addAppointment(appointment);

    if (response.status == ResponseStatus.success) {
      emit(AppointmentAddAppointmentSuccess(response.data ?? AppointmentEntity()));
    } else {
      emit(AppointmentAddAppointmentFailed());
    }
  }

  editAppointment(AppointmentEntity appointment) async {
    emit(AppointmentLoading());

    final response = await appointmentRepository.editAppointment(appointment);

    if (response.status == ResponseStatus.success) {
      emit(AppointmentEditAppointmentSuccess(response.data ?? AppointmentEntity()));
    } else {
      emit(AppointmentAddAppointmentFailed());
    }
  }

  getCalendarDayEvent(DateTime date) async {
    emit(AppointmentLoading());

    final response = await appointmentRepository.getCalendarDayEvent(date);

    if (response.status == ResponseStatus.success) {
      emit(AppointmentGetCalendarDayEventSuccess(response.data ?? CalendarEvent()));
    } else {
      emit(AppointmentGetCalendarDayEventFailed());
    }
  }

  getCalendarEvent(int month, int year) async {
    emit(AppointmentLoading());

    final response = await appointmentRepository.getCalendarEvent(month, year);

    if (response.status == ResponseStatus.success) {
      emit(AppointmentGetCalendarEventSuccess(response.data ?? {}));
    } else {
      emit(AppointmentGetCalendarEventFailed());
    }
  }
}
