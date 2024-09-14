import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../../model/api/base_response.dart';

import '../../../../../../data/repository/remote/landing_page_repository.dart';
import '../../../../../../di/di.dart';
import '../../../../../../model/business/landing_page/landing_page_image_response.dart';

part 'category_images_event.dart';
part 'category_images_state.dart';

class CategoryImagesBloc
    extends Bloc<CategoryImagesEvent, CategoryImagesState> {
  LandingPageRepository landingPageRepository =
      getIt.get<LandingPageRepository>();
  String currentLandingId = '';
  List<LandingPageImageResponse> list = [];
  List<LandingPageImageResponse> listPresent = [];

  CategoryImagesBloc() : super(CategoryImagesLoading()) {
    on<CategoryImagesEvent>((event, emit) {});
    on<CategoryImagesInitEvent>(init);
    on<CategoryImagesUpdateEvent>(updateImage);
  }

  FutureOr<void> init(
      CategoryImagesInitEvent event, Emitter<CategoryImagesState> emit) async {
    currentLandingId = event.landingId;
    ResponseWrapper response =
        await landingPageRepository.getImage(landingId: event.landingId);
    if (response.status == ResponseStatus.success) {
      list = response.data;
      listPresent.addAll(list);
      emit(CategoryImagesInitial(listImage: list));
    }
  }

  FutureOr<void> updateImage(CategoryImagesUpdateEvent event,
      Emitter<CategoryImagesState> emit) async {
    log("landingId: $currentLandingId");
    ResponseWrapper response = await landingPageRepository.addImage(
        landingId: currentLandingId, value: event.listImageUri);
    if (response.status == ResponseStatus.success) {
      list = response.data;
      listPresent = [];
      listPresent.addAll(list);
      emit(CategoryImagesInitial(listImage: listPresent));
    }
  }
}
