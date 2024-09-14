import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../../model/business/landing_page/landing_page_link_response.dart';

import '../../../../../../data/repository/remote/landing_page_repository.dart';
import '../../../../../../di/di.dart';
import '../../../../../../model/api/base_response.dart';

part 'category_link_event.dart';
part 'category_link_state.dart';

class CategoryLinkBloc extends Bloc<CategoryLinkEvent, CategoryLinkState> {
  String currentLandingId = '';
  LandingPageLinkResponse currentLink = LandingPageLinkResponse();
  LandingPageRepository landingPageRepository =
      getIt.get<LandingPageRepository>();
  CategoryLinkBloc() : super(CategoryLinkLoading()) {
    on<CategoryLinkEvent>((event, emit) {});
    on<CategoryLinkInitEvent>(init);
    on<CategoryLinkUpdateEvent>(updateLink);
  }

  FutureOr<void> init(
      CategoryLinkInitEvent event, Emitter<CategoryLinkState> emit) async {
    currentLandingId = event.landingId;
    ResponseWrapper response =
        await landingPageRepository.getLink(landingId: event.landingId);
    if (response.status == ResponseStatus.success) {
      currentLink = response.data;
      emit(CategoryLinkInitial(currentLink: currentLink));
    }
  }

  FutureOr<void> updateLink(
      CategoryLinkUpdateEvent event, Emitter<CategoryLinkState> emit) async {
    ResponseWrapper response = await landingPageRepository.addLink(
        linkId: currentLink.id,
        landingId: currentLandingId,
        value: event.link,
        title: event.title);
    if (response.status == ResponseStatus.success) {
      currentLink = response.data;
      emit(CategoryLinkInitial(currentLink: currentLink));
    }
  }
}
