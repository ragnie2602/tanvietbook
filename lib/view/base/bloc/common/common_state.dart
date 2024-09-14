part of 'common_cubit.dart';

abstract class CommonState {}

class CommonInitial extends CommonState {}

class CommonShowLoadingState extends CommonState {
  final bool isLoading;
  final bool isdismissible;

  CommonShowLoadingState({
    required this.isLoading,
    this.isdismissible = true,
  });
}

class CommonToastMessage extends CommonState {
  final bool isShow;
  final String? message;
  final Widget? child;
  CommonToastMessage({
    required this.isShow,
    this.message,
    this.child,
  });
}

class CommonOnBottomNavigationPressed extends CommonState {
  final int index;

  CommonOnBottomNavigationPressed({required this.index});
}
