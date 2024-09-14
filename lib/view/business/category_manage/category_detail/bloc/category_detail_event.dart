part of 'category_detail_bloc.dart';

@immutable
abstract class CategoryDetailEvent {}

class CategoryDetailInitEvent extends CategoryDetailEvent {
  final String categoryId;

  CategoryDetailInitEvent({required this.categoryId});
}

class CategoryDetailCreateEvent extends CategoryDetailEvent {
  final String categoryId;

  CategoryDetailCreateEvent({required this.categoryId});
}

class CategoryDetailCreateLandingPageItemEvent extends CategoryDetailEvent {
  final String categoryId;
  final int landingPageType;

  CategoryDetailCreateLandingPageItemEvent(
      {required this.categoryId, required this.landingPageType});
}

class CategoryDetailChangePositionEvent extends CategoryDetailEvent {
  final ChangePositionType type;

  CategoryDetailChangePositionEvent({required this.type});
}

class CategoryDetailDeleteEvent extends CategoryDetailEvent {
  final String landingId;

  CategoryDetailDeleteEvent({required this.landingId});
}

class CategorySaveCancelChangePositionEvent extends CategoryDetailEvent {
  final bool isSave;

  CategorySaveCancelChangePositionEvent({required this.isSave});
}

class CategoryDetailCancelChange extends CategoryDetailEvent {}

class CategoryDetailSetCurrentIndexFocus extends CategoryDetailEvent {
  final int currentIndex;

  CategoryDetailSetCurrentIndexFocus({required this.currentIndex});
}

class CategoryImagesAddEvent extends CategoryDetailEvent {
  final List<String> listImageUri;
  final int position;

  CategoryImagesAddEvent({required this.position, required this.listImageUri});
}

class CategoryContentAddEvent extends CategoryDetailEvent {
  final String value;
  final int position;

  CategoryContentAddEvent({required this.position, required this.value});
}

class CategoryCallActionAddEvent extends CategoryDetailEvent {
  final String title;
  final String actionInfor;
  final List<String> listAction;
  final int position;

  CategoryCallActionAddEvent({
    required this.position,
    required this.listAction,
    required this.title,
    required this.actionInfor,
  });
}

class CategoryLinkAddEvent extends CategoryDetailEvent {
  final String title;
  final String link;
  final int position;

  CategoryLinkAddEvent(
      {required this.position, required this.title, required this.link});
}

class CategoryButtonAddEvent extends CategoryDetailEvent {
  final int position;
  final String value;
  final int border;
  final String backgroundColor;
  final String textColor;

  CategoryButtonAddEvent(
      {required this.value,
      required this.border,
      required this.backgroundColor,
      required this.textColor,
      required this.position});
}

class CategoryButtonScrollToCTAEvent extends CategoryDetailEvent {}
