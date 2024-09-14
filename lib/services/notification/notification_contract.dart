import 'package:signalr_netcore/hub_connection.dart';

import '../../model/api/base_response.dart';
import '../../model/notification/notification_detail_response.dart';

abstract class NotificationServiceContract {
  Future<bool> initialize();

  Future<HubConnection> getHubConnection();

  Future<void> dispose();

  Future<ResponseWrapper<List<NotificationDetailResponse>>> getAllNotification(
      String? typeId,
      {int page = 1,
      int pageSize = 15});

  Future<ResponseWrapper<int>> getNotificationCountNotSeenByUser(
      String? typeId);

  Future<ResponseWrapper<bool>> updateSeenOneNotification({String? id});
}
