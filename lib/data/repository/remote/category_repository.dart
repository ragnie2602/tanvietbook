import '../../constants.dart';
import '../../../model/business/category/category_list_item.dart';

import '../../../model/api/base_response.dart';
import '../../../model/business/category/business_category_response.dart';

abstract class CategoryRepository {
  Future<ResponseWrapper<BusinessCategoryResponse>> createCategory(
      {required BusinessCategoryResponse category});

  Future<ResponseWrapper<bool>> swapCategory(List<String> idList);

  Future<ResponseWrapper<bool>> updateCategory(
      {required Map<String, dynamic> data});

  Future<ResponseWrapper<BusinessCategoryGetAllResponse>>
      getAllBusinessCategoryByType(
          {required String subTabId,
          String? username,
          required int page,
          required int pageSize,
          String type = CategoryType.all});

  Future<ResponseWrapper<BusinessCategoryGetAllResponse>>
      getAllBusinessCategory({required String subTabId, String? username});

  Future<ResponseWrapper<bool>> deleteCategory(String id);

  Future<ResponseWrapper<List<CategoryListItem>>> getUninitializedList(
      {required String? subTabId});
}
