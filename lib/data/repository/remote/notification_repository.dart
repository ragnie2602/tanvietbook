import '../../../model/api/base_response.dart';
import '../../../model/notification/notification_category_response.dart';
import '../../../model/notification/notification_detail_response.dart';

abstract class NotificationRepository {
  Future<ResponseWrapper<List<NotificationCategoryResponse>>> getAllCategories(
      {int pageNum = 1, int pageSize = 10000});

  Future<ResponseWrapper<List<NotificationDetailResponse>>> getAllNotification({
    int pageNum = 1,
    int pageSize = 10,
    String? categoryId,
    String? keyword,
  });

  Future<ResponseWrapper<bool>> registerFCMToken();
}
