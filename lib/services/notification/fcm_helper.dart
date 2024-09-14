import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:signalr_netcore/hub_connection.dart';

import '../../model/api/base_response.dart';
import '../../model/notification/notification_detail_response.dart';
import 'notification_contract.dart';

class FCMHelper implements NotificationServiceContract {
  FCMHelper._();

  static FCMHelper? _instance;
  static FCMHelper get instance => _instance ??= FCMHelper._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  Future<bool> initialize({
    Function(RemoteMessage message)? onForegroundMessage,
    Function(RemoteMessage message)? onBackgroundMessage,
  }) async {
    NotificationSettings notificationSettings =
        await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((event) {
        log('FirebaseMessaging.onMessage: $event');
        log('FirebaseMessaging.onMessage time:  ${event.sentTime}');
        log('FirebaseMessaging.onMessage body: ${event.notification?.body}');
        onForegroundMessage?.call(event);
      }, onError: (e) {
        log('FirebaseMessaging.onMessage: $e');
      });

      FirebaseMessaging.onBackgroundMessage((message) async {
        log('FirebaseMessaging.onBackgroundMessage: $message');
        log('FirebaseMessaging.onBackgroundMessage data: ${message.data}');
        log('FirebaseMessaging.onBackgroundMessage body: ${message.notification?.body}');
        onBackgroundMessage?.call(message);
        return;
      });
    } else {
      log('User declined or has not accepted permission');
    }
    return true;
  }

  Future<String> getFcmToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    return token ?? '';
  }

  @override
  Future<void> dispose() {
    throw UnimplementedError();
  }

  @override
  Future<ResponseWrapper<List<NotificationDetailResponse>>> getAllNotification(
      String? typeId,
      {int page = 1,
      int pageSize = 15}) {
    // TODO: implement getAllNotification
    throw UnimplementedError();
  }

  @override
  Future<ResponseWrapper<int>> getNotificationCountNotSeenByUser(
      String? typeId) {
    // TODO: implement getNotificationCountNotSeenByUser
    throw UnimplementedError();
  }

  @override
  Future<HubConnection> getHubConnection() {
    // TODO: implement getHubConnection
    throw UnimplementedError();
  }

  @override
  Future<ResponseWrapper<bool>> updateSeenOneNotification({String? id}) {
    // TODO: implement updateSeenOneNotification
    throw UnimplementedError();
  }
}
