part of 'category_button_bloc.dart';

@immutable
abstract class CategoryButtonState {}

class CategoryButtonInitial extends CategoryButtonState {
  final LandingPageButtonResponse landingPageButtonResponse;

  CategoryButtonInitial({required this.landingPageButtonResponse});
}

class CategoryButtonLoading extends CategoryButtonState {}
