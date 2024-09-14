part of 'business_bloc.dart';

abstract class BusinessEvent {}

class BusinessInitialEvent extends BusinessEvent {}

class BusinessGetAllEvent extends BusinessEvent {
  final String? username;

  BusinessGetAllEvent({this.username});
}

class BusinessGetOverallEvent extends BusinessEvent {}

class BusinessGetDetailEvent extends BusinessEvent {
  BusinessGetDetailEvent();
}

class BusinessRebuildEvent extends BusinessEvent {}

class BusinessGetCategoryEvent extends BusinessEvent {
  final String? username;
  final String? subTabId;
  final String type;

  BusinessGetCategoryEvent(
      {this.username, this.subTabId, this.type = CategoryType.all});
}

class BusinessGetSubTabEvent extends BusinessEvent {
  final String? username;

  BusinessGetSubTabEvent({this.username});
}

class BusinessGetAllProductEvent extends BusinessEvent {
  final String? username;
  final String? subTabId;
  final String? categoryId;
  final String? keyword;

  final int pageNum;
  final int pageSize;

  BusinessGetAllProductEvent({
    required this.pageNum,
    this.username,
    required this.pageSize,
    this.categoryId,
    this.subTabId,
    this.keyword,
  });
}

class BusinessChangePositionProductEvent extends BusinessEvent {
  final List<String> pidList;
  final String? categoryId;

  BusinessChangePositionProductEvent({required this.pidList, this.categoryId});
}

class BusinessGetProductDetailEvent extends BusinessEvent {
  final String pid;

  BusinessGetProductDetailEvent({required this.pid});
}

class BusinessAddNewProductEvent extends BusinessEvent {
  final ProductDetailResponse productDetailResponse;

  BusinessAddNewProductEvent({required this.productDetailResponse});
}

class BusinessDeleteProductDetailEvent extends BusinessEvent {
  final String pid;
  final int index;

  BusinessDeleteProductDetailEvent({required this.pid, required this.index});
}

class BusinessFilterDataChanged extends BusinessEvent {}
