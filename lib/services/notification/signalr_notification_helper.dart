import 'dart:async';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_netcore/ihub_protocol.dart';
import 'package:signalr_netcore/signalr_client.dart';

import '../../config/config.dart';
import '../../data/repository/local/local_data_access.dart';
import '../../di/di.dart';
import '../../model/api/base_response.dart';
import '../../model/notification/notification_detail_response.dart';
import 'notification_contract.dart';

class SignalRNotificationHelper implements NotificationServiceContract {
  final LocalDataAccess _localDataAccess = getIt.get();
  late HubConnection _hubConnection;

  HubConnection get hubConnection => _hubConnection;

  @override
  Future<bool> initialize() async {
    final String accessToken = _localDataAccess.getAccessToken();
    final messageHeader = MessageHeaders()
      ..setHeaderValue('Authorization', 'Bearer $accessToken')
      ..addMessageHeaders(MessageHeaders()
        ..setHeaderValue("Content-type", "application/json; charset=utf-8"));
    _hubConnection = HubConnectionBuilder()
        .withUrl(
          "${Environment.notificationServiceBaseUrl}/notificationHub",
          options: HttpConnectionOptions(
            accessTokenFactory: () => Future(() async => accessToken),
            headers: messageHeader,
            logMessageContent: true,
            requestTimeout: 10000,
          ),
        )
        .withAutomaticReconnect()
        .build();

    try {
      await _hubConnection.start();
      log("hub connectionId: ${_hubConnection.connectionId}");
      await SharedPreferences.getInstance().then(
        (value) => value.setString(
            "connectionId", _hubConnection.connectionId.toString()),
      );
      return true;
    } catch (e) {
      log('exception at initialization process: $e');
      return false;
      // log(e.toString());
    }
  }

  @override
  Future<void> dispose() async {
    log('disposing...');
    _hubConnection.stop();
  }

  @override
  Future<ResponseWrapper<List<NotificationDetailResponse>>> getAllNotification(
      String? typeId,
      {int page = 0,
      int pageSize = 15}) async {
    final response =
        await _hubConnection.invoke('GetNotificationByUser', args: [
      {
        "userId": _localDataAccess.getUserId(),
        "type": typeId == 'all' ? null : typeId,
        "page": page,
        "pageSize": pageSize,
      }..removeWhere((key, value) => value == null),
      _hubConnection.connectionId ?? '',
    ]);
    if (response != null) {
      final pagingData =
          DefaultPagingResponse<List<NotificationDetailResponse>>.fromJson(
        response as Map<String, dynamic>,
        (json) => (json as List)
            .map((e) => NotificationDetailResponse.fromJson(e))
            .toList(),
      );

      return ResponseWrapper.success(
        data: pagingData.data ?? [],
      );
    }
    return ResponseWrapper.error(message: 'error on getting hub notification');
  }

  @override
  Future<ResponseWrapper<int>> getNotificationCountNotSeenByUser(
      String? typeId) async {
    try {
      await _hubConnection.invoke('GetNotificationNotSeenByUser', args: [
        {
          "userId": _localDataAccess.getUserId(),
          "type": typeId,
        },
        _hubConnection.connectionId ?? '',
      ]);

      return ResponseWrapper.success(data: 0);
    } catch (e) {
      log('hub get count not seen error: $e');
      return ResponseWrapper.success(data: 0);
    }
  }

  Future<ResponseWrapper<bool>> updateSeenAllNotification() async {
    final response =
        await _hubConnection.invoke('UpdateSeenAllNotification', args: [
      {
        "UserId": _localDataAccess.getUserId(),
      }
    ]);

    return ResponseWrapper.success(data: true);
  }

  @override
  Future<ResponseWrapper<bool>> updateSeenOneNotification({String? id}) async {
    final response =
        await _hubConnection.invoke('UpdateSeenOneNotification', args: [
      {
        "UserId": _localDataAccess.getUserId(),
        "NotificationId": id,
      },
      _hubConnection.connectionId ?? '',
    ]);
    return ResponseWrapper.success(data: true);
  }

  @override
  Future<HubConnection> getHubConnection() async {
    return Future.value(hubConnection);
  }
}
