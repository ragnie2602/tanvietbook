part of 'suggested_contact_bloc.dart';

@immutable
abstract class SuggestedContactState {}

class SuggestedContactInitial extends SuggestedContactState {
  final SuggestedContactsResponse suggestedContactsResponse;

  SuggestedContactInitial({required this.suggestedContactsResponse});
}

class SuggestedContactLoading extends SuggestedContactState {}
