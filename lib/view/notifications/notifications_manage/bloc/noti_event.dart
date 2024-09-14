part of 'noti_bloc.dart';

abstract class ManageNotiEvent {}

class NotificationGetConnectionIdEvent extends ManageNotiEvent {}

class NotificationInitialEvent extends ManageNotiEvent {}

class NotificationRegisterFCMTokenEvent extends ManageNotiEvent {}

class NotificationDisposeEvent extends ManageNotiEvent {}

class NotificationInitializeListenerEvent extends ManageNotiEvent {}

class NotificationGetAllCategoriesEvent extends ManageNotiEvent {}

class NotificationGetAllEvent extends ManageNotiEvent {
  final String? categoryId;
  final int pageNum;
  final int pageSize;
  final String? keyword;

  NotificationGetAllEvent({
    this.categoryId,
    this.pageNum = 1,
    this.pageSize = 20,
    this.keyword,
  });
}

class NotificationReceiveListEvent extends ManageNotiEvent {
  final List<NotificationDetailResponse> notifications;
  final String type;

  NotificationReceiveListEvent({
    required this.notifications,
    required this.type,
  });
}

class NotificationReceivetNotSeenCountEvent extends ManageNotiEvent {
  final int count;
  final String type;

  NotificationReceivetNotSeenCountEvent(
      {required this.count, required this.type});
}

class NotificationReceivetUpdateSeenEvent extends ManageNotiEvent {}

class NotificationReceivetNewMessageEvent extends ManageNotiEvent {
  final NotificationDetailResponse notificationDetailResponse;

  NotificationReceivetNewMessageEvent(
      {required this.notificationDetailResponse});
}

class NotificationGetNotSeenCountEvent extends ManageNotiEvent {
  final String? typeId;

  NotificationGetNotSeenCountEvent({required this.typeId});
}

class NotificationOnNewMessageEvent extends ManageNotiEvent {
  final dynamic data;

  NotificationOnNewMessageEvent({required this.data});
}

class NotificationUpdateSeenNotificationEvent extends ManageNotiEvent {
  final String id;

  NotificationUpdateSeenNotificationEvent({required this.id});
}
