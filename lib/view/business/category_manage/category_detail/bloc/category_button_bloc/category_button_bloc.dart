import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../../model/business/landing_page/landing_page_button_response.dart';

import '../../../../../../data/repository/remote/landing_page_repository.dart';
import '../../../../../../di/di.dart';
import '../../../../../../model/api/base_response.dart';

part 'category_button_event.dart';
part 'category_button_state.dart';

class CategoryButtonBloc
    extends Bloc<CategoryButtonEvent, CategoryButtonState> {
  String currentLandingId = '';
  LandingPageButtonResponse buttonValue = LandingPageButtonResponse();
  LandingPageButtonResponse buttonValuePresent = LandingPageButtonResponse();
  LandingPageRepository landingPageRepository =
      getIt.get<LandingPageRepository>();

  CategoryButtonBloc() : super(CategoryButtonLoading()) {
    on<CategoryButtonEvent>((event, emit) {});
    on<CategoryButtonInitEvent>(init);
    on<CategoryButtonUpdateEvent>(updateButton);
  }

  FutureOr<void> init(
      CategoryButtonInitEvent event, Emitter<CategoryButtonState> emit) async {
    currentLandingId = event.landingId;
    ResponseWrapper response =
        await landingPageRepository.getButton(landingId: event.landingId);
    if (response.status == ResponseStatus.success) {
      buttonValue = response.data;
      buttonValuePresent = buttonValue;
      emit(CategoryButtonInitial(landingPageButtonResponse: buttonValue));
    }
  }

  FutureOr<void> updateButton(CategoryButtonUpdateEvent event,
      Emitter<CategoryButtonState> emit) async {
    ResponseWrapper response = await landingPageRepository.addButton(
        data: buttonValuePresent.toJson()
          ..removeWhere((key, value) => value == null || value == ''));
    if (response.status == ResponseStatus.success) {
      buttonValue = response.data;
      emit(CategoryButtonInitial(landingPageButtonResponse: buttonValue));
    }
  }
}
