part of 'business_update_bloc.dart';

@immutable
abstract class BusinessUpdateEvent {}

class BusinessUpdateInfoEvent extends BusinessUpdateEvent {
  final List<String> bannersImagePath;

  BusinessUpdateInfoEvent({required this.bannersImagePath});
}

class BusinessCreateNewProductEvent extends BusinessUpdateEvent {}

class BusinessUpdateProductEvent extends BusinessUpdateEvent {}
