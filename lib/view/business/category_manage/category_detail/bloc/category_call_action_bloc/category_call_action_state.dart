part of 'category_call_action_bloc.dart';

@immutable
abstract class CategoryCallActionState {}

class CategoryCallActionInitial extends CategoryCallActionState {
  final LandingPageCallActionResponse callActionInfo;

  CategoryCallActionInitial({required this.callActionInfo});
}

class CategoryCallActionCreateSuccessState extends CategoryCallActionState {
  final ConcernResponse concernResponse;

  CategoryCallActionCreateSuccessState({required this.concernResponse});
}

class CategoryCallActionCreateFailedState extends CategoryCallActionState {}

class CategoryCallActionGetAllSuccessState extends CategoryCallActionState {
  final List<ConcernResponse> concernList;

  CategoryCallActionGetAllSuccessState({required this.concernList});
}

class CategoryCallActionGetAllFailedState extends CategoryCallActionState {}

class CategoryCallActionLoading extends CategoryCallActionState {}
