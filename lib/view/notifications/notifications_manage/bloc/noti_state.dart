part of 'noti_bloc.dart';

abstract class ManageNotiState {}

class ManageNotiInit extends ManageNotiState {}

class NotiSuccess extends ManageNotiState {
  // NotificationsResponse? response;
  List<Notifications> listNotificationsSystem;
  List<Notifications> listNotificationsIndividual;

  NotiSuccess(this.listNotificationsSystem, this.listNotificationsIndividual);
}

class NotiFail extends ManageNotiState {}

class NotificationGetAllCategoriesSuccessState extends ManageNotiState {
  final List<NotificationCategoryResponse> notificationCategories;

  NotificationGetAllCategoriesSuccessState(this.notificationCategories);
}

class NotificationGetAllCategoriesFailedState extends ManageNotiState {}

class NotificationInitializeSuccessState extends ManageNotiState {}

class NotificationGetAllSuccessState extends ManageNotiState {
  final List<NotificationDetailResponse> notifications;
  final String? categoryId;

  NotificationGetAllSuccessState(this.notifications, this.categoryId);
}

class NotificationGetAllFailedState extends ManageNotiState {}

class NotificationReceivetUpdateSeenState extends ManageNotiState {}

class NotificationGetNotSeenCountSuccessState extends ManageNotiState {
  final int count;
  final String type;

  NotificationGetNotSeenCountSuccessState(this.count, this.type);
}

class NotificationReceiveNewMessageSuccessState extends ManageNotiState {
  final NotificationDetailResponse notificationDetailResponse;

  NotificationReceiveNewMessageSuccessState(this.notificationDetailResponse);
}
