part of 'category_detail_bloc.dart';

@immutable
abstract class CategoryDetailState {}

class CategoryDetailInitial extends CategoryDetailState {
  final List<LandingPageResponse> list;

  CategoryDetailInitial({required this.list});
}

class CategoryDetailLoading extends CategoryDetailState {}

class CategoryDetailScrollToCTAState extends CategoryDetailState {
  final GlobalKey key;

  CategoryDetailScrollToCTAState({required this.key});
}
