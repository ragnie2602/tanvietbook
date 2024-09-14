import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../data/repository/remote/category_repository.dart';
import '../../../../../di/di.dart';
import '../../../../../model/api/base_response.dart';

import '../../../../../data/repository/local/local_data_access.dart';
import '../../../../../model/business/category/category_list_item.dart';

part 'add_category_content_event.dart';
part 'add_category_content_state.dart';

class AddCategoryContentBloc
    extends Bloc<AddCategoryContentEvent, AddCategoryContentState> {
  CategoryRepository categoryRepository = getIt.get<CategoryRepository>();
  List<CategoryListItem> listCategory = [];

  AddCategoryContentBloc() : super(AddCategoryContentLoading()) {
    on<AddCategoryContentInitEvent>((event, emit) async {
      ResponseWrapper<List<CategoryListItem>> response =
          await categoryRepository.getUninitializedList(
              subTabId: event.subTabId);

      listCategory = response.data ?? [];
      emit(AddCategoryContentInitial(listCategory: listCategory));
      final LocalDataAccess localDataAccess = getIt.get<LocalDataAccess>();
      final String accessToken = localDataAccess.getAccessToken();
      final String id = localDataAccess.getUserId();
      log(accessToken);
      log(id);
      // Response response = await categoryRepository.getBusinessTab(memberId);
    });
  }
}
