part of 'appointment_cubit.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();
  @override
  List<Object?> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentAddAppointmentSuccess extends AppointmentState {
  final AppointmentEntity appointment;

  const AppointmentAddAppointmentSuccess(this.appointment);
  @override
  List<Object?> get props => [appointment];
}

class AppointmentAddAppointmentFailed extends AppointmentState {}

class AppointmentEditAppointmentSuccess extends AppointmentState {
  final AppointmentEntity appointment;

  const AppointmentEditAppointmentSuccess(this.appointment);
  @override
  List<Object?> get props => [appointment];
}

class AppointmentEditAppointmentFailed extends AppointmentState {}

class AppointmentGetCalendarDayEventSuccess extends AppointmentState {
  final CalendarEvent calendarEvent;

  const AppointmentGetCalendarDayEventSuccess(this.calendarEvent);
  @override
  List<Object?> get props => [calendarEvent];
}

class AppointmentGetCalendarDayEventFailed extends AppointmentState {}

class AppointmentGetCalendarEventSuccess extends AppointmentState {
  final Map<String, List<String>> calendarEvent;

  const AppointmentGetCalendarEventSuccess(this.calendarEvent);
  @override
  List<Object?> get props => [calendarEvent];
}

class AppointmentGetCalendarEventFailed extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentViewUserSuccess extends AppointmentState {
  final bool existed;

  const AppointmentViewUserSuccess(this.existed);
  @override
  List<Object?> get props => [existed];
}

class AppointmentViewUserFailed extends AppointmentState {}
