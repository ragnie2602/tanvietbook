import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../../data/repository/remote/landing_page_repository.dart';
import '../../../../../../di/di.dart';
import '../../../../../../model/business/landing_page/landing_page_content_response.dart';

import '../../../../../../model/api/base_response.dart';

part 'category_content_event.dart';
part 'category_content_state.dart';

class CategoryContentBloc
    extends Bloc<CategoryContentEvent, CategoryContentState> {
  String currentLandingId = '';
  LandingPageContentResponse currentValue = LandingPageContentResponse();
  LandingPageRepository landingPageRepository =
      getIt.get<LandingPageRepository>();

  CategoryContentBloc() : super(CategoryContentLoading()) {
    on<CategoryContentEvent>((event, emit) {});
    on<CategoryContentInitEvent>(init);
    on<CategoryContentUpdateEvent>(updateContent);
  }

  FutureOr<void> init(CategoryContentInitEvent event,
      Emitter<CategoryContentState> emit) async {
    currentLandingId = event.landingId;
    ResponseWrapper response =
        await landingPageRepository.getContent(landingId: event.landingId);
    if (response.status == ResponseStatus.success) {
      currentValue = response.data as LandingPageContentResponse;
      emit(CategoryContentInitial(valueContent: currentValue));
    }
  }

  FutureOr<void> updateContent(CategoryContentUpdateEvent event,
      Emitter<CategoryContentState> emit) async {
    ResponseWrapper response = await landingPageRepository.addContent(
        landingId: currentLandingId,
        value: event.value,
        contentId: event.contentId);
    if (response.status == ResponseStatus.success) {
      emit(CategoryContentInitial(
          valueContent: response.data as LandingPageContentResponse));
    }
  }
}
