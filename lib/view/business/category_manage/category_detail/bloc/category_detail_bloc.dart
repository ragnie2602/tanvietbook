import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../data/constants.dart';
import '../../../../../data/repository/remote/landing_page_repository.dart';
import '../../../../../model/api/base_response.dart';
import '../../../../../shared/utils/view_utils.dart';

import '../../../../../di/di.dart';
import '../../../../../model/business/landing_page/landing_page_response.dart';

part 'category_detail_event.dart';
part 'category_detail_state.dart';

class CategoryDetailBloc
    extends Bloc<CategoryDetailEvent, CategoryDetailState> {
  List<LandingPageResponse> list = [];
  List<LandingPageResponse> listPresent = [];
  String currentId = '';
  int currentIndex = 0;

  LandingPageRepository landingPageRepository =
      getIt.get<LandingPageRepository>();

  CategoryDetailBloc() : super(CategoryDetailLoading()) {
    on<CategoryDetailInitEvent>(init);
    on<CategoryDetailChangePositionEvent>(changePosition);
    on<CategorySaveCancelChangePositionEvent>(saveCancelChangePosition);
    on<CategoryDetailDeleteEvent>(delete);
    on<CategoryDetailCreateEvent>((event, emit) {
      currentId = event.categoryId;
      emit(CategoryDetailInitial(list: listPresent));
    });
    on<CategoryDetailSetCurrentIndexFocus>((event, emit) {
      currentIndex = event.currentIndex;
    });
    on<CategoryImagesAddEvent>(addImage);
    on<CategoryContentAddEvent>(addContent);
    on<CategoryLinkAddEvent>(addLink);
    on<CategoryCallActionAddEvent>(addCallAction);
    on<CategoryButtonAddEvent>(addButton);
    on<CategoryButtonScrollToCTAEvent>(scrollToCTA);
  }

  FutureOr<void> init(
      CategoryDetailInitEvent event, Emitter<CategoryDetailState> emit) async {
    currentId = event.categoryId;
    ResponseWrapper<List<LandingPageResponse>> response =
        await landingPageRepository.getAll(event.categoryId);
    list = response.data ?? [];
    for (int i = 0; i < list.length; i++) {
      list[i].key = GlobalKey();
    }
    listPresent = [];
    listPresent.addAll(list);
    emit(CategoryDetailInitial(list: listPresent));
  }

  FutureOr<void> changePosition(CategoryDetailChangePositionEvent event,
      Emitter<CategoryDetailState> emit) {
    int oldIndex = currentIndex, newIndex = 0;
    switch (event.type) {
      case ChangePositionType.up:
        newIndex = oldIndex - 1;
        break;
      case ChangePositionType.down:
        newIndex = oldIndex + 1;
        break;
      case ChangePositionType.upToTop:
        newIndex = 0;
        break;
      case ChangePositionType.downToBottom:
        newIndex = listPresent.length + 1;
        break;
    }
    if (newIndex < 0) newIndex = 0;
    var item = listPresent.removeAt(oldIndex);
    if (newIndex > listPresent.length) newIndex = listPresent.length;
    listPresent.insert(newIndex, item);
    currentIndex = newIndex;
    emit(CategoryDetailInitial(list: listPresent));
  }

  FutureOr<void> saveCancelChangePosition(
      CategorySaveCancelChangePositionEvent event,
      Emitter<CategoryDetailState> emit) async {
    if (event.isSave) {
      ResponseWrapper response = await landingPageRepository.swapItem(
          idList: listPresent.map((e) => e.id ?? '').toList(),
          cateId: currentId);
      if (response.status == ResponseStatus.success) {
        toastSuccess("Đổi vị trí thành công");
      } else {
        toastWarning("Đổi vị trí thất bại");
        listPresent = [];
        listPresent.addAll(list);
        emit(CategoryDetailInitial(list: listPresent));
      }
    } else {
      listPresent = [];
      listPresent.addAll(list);
      emit(CategoryDetailInitial(list: listPresent));
    }
  }

  FutureOr<void> delete(CategoryDetailDeleteEvent event,
      Emitter<CategoryDetailState> emit) async {
    ResponseWrapper response = await landingPageRepository.deleteLandingPage(
        landingPageId: event.landingId);
    if (response.status == ResponseStatus.success) {
      await init(CategoryDetailInitEvent(categoryId: currentId), emit);
    }
  }

  FutureOr<void> addImage(
      CategoryImagesAddEvent event, Emitter<CategoryDetailState> emit) async {
    ResponseWrapper response =
        await landingPageRepository.createLandingPageItem({
      "categoryID": currentId,
      "type": 0,
      "priority": event.position,
    });
    if (response.status == ResponseStatus.success) {
      LandingPageResponse landingPageResponse = response.data;
      response = await landingPageRepository.addImage(
          landingId: landingPageResponse.id ?? '', value: event.listImageUri);
      if (response.status == ResponseStatus.success) {
        await init(CategoryDetailInitEvent(categoryId: currentId), emit);
      }
    }
  }

  FutureOr<void> addContent(
      CategoryContentAddEvent event, Emitter<CategoryDetailState> emit) async {
    ResponseWrapper response =
        await landingPageRepository.createLandingPageItem({
      "categoryID": currentId,
      "type": 1,
      "priority": event.position,
    });
    if (response.status == ResponseStatus.success) {
      LandingPageResponse landingPageResponse = response.data;
      response = await landingPageRepository.addContent(
          landingId: landingPageResponse.id ?? '', value: event.value);
      if (response.status == ResponseStatus.success) {
        await init(CategoryDetailInitEvent(categoryId: currentId), emit);
      }
    }
  }

  FutureOr<void> addLink(
      CategoryLinkAddEvent event, Emitter<CategoryDetailState> emit) async {
    ResponseWrapper response =
        await landingPageRepository.createLandingPageItem({
      "categoryID": currentId,
      "type": 2,
      "priority": event.position,
    });
    if (response.status == ResponseStatus.success) {
      LandingPageResponse landingPageResponse = response.data;
      response = await landingPageRepository.addLink(
          landingId: landingPageResponse.id ?? '',
          value: event.link,
          title: event.title);
      if (response.status == ResponseStatus.success) {
        await init(CategoryDetailInitEvent(categoryId: currentId), emit);
      }
    }
  }

  FutureOr<void> addCallAction(CategoryCallActionAddEvent event,
      Emitter<CategoryDetailState> emit) async {
    LandingPageResponse? check = list.firstWhere((element) => element.type == 3,
        orElse: () => LandingPageResponse());
    if (check.id != null) {
      toastWarning("Chỉ được tạo 1 lời kêu gọi trong Landing Page");
      return;
    }
    ResponseWrapper response =
        await landingPageRepository.createLandingPageItem({
      "categoryID": currentId,
      "type": 3,
      "priority": event.position,
    });
    if (response.status == ResponseStatus.success) {
      LandingPageResponse landingPageResponse = response.data;
      response = await landingPageRepository.addCallAction(
          data: {
        "landingID": landingPageResponse.id ?? '',
        "title": event.title,
        "actionInfor": event.actionInfor,
        // "background": callActionInfo.background,
        "actions": event.listAction
      }..removeWhere((key, value) => value == null || value == ''));
      if (response.status == ResponseStatus.success) {
        await init(CategoryDetailInitEvent(categoryId: currentId), emit);
      }
    }
  }

  FutureOr<void> addButton(
      CategoryButtonAddEvent event, Emitter<CategoryDetailState> emit) async {
    ResponseWrapper response =
        await landingPageRepository.createLandingPageItem({
      "categoryID": currentId,
      "type": 4,
      "priority": event.position,
    });
    if (response.status == ResponseStatus.success) {
      LandingPageResponse landingPageResponse = response.data;
      response = await landingPageRepository.addButton(
          data: {
        "landingID": landingPageResponse.id ?? '',
        // "actionID": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
        // "link": "string",
        // "title": "string",
        // "actionInfor": "string",
        // "actions": [
        //   "string"
        // ],
        // "backgroundAction": "string",
        // "backgroundColorAction": "string",
        "value": event.value,
        "border": event.border,
        "textColor": event.textColor,
        "backgroundColor": event.backgroundColor,
        "type": 0
      }..removeWhere((key, value) => value == null || value == ''));
      if (response.status == ResponseStatus.success) {
        await init(CategoryDetailInitEvent(categoryId: currentId), emit);
      }
    }
  }

  FutureOr<void> scrollToCTA(
      CategoryButtonScrollToCTAEvent event, Emitter<CategoryDetailState> emit) {
    emit(CategoryDetailScrollToCTAState(
        key: listPresent.firstWhere((element) => element.type == 3).key));
  }
}
