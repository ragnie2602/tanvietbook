part of 'suggested_contact_bloc.dart';

@immutable
abstract class SuggestedContactEvent {}

class SuggestedContactInitEvent implements SuggestedContactEvent {}

class SuggestedContactAddEvent implements SuggestedContactEvent {
  final String memberId;
  final String? username;

  SuggestedContactAddEvent({required this.memberId, this.username});
}
