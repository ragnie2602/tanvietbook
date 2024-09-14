import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../../../data/repository/remote/repository.dart';
import '../../../../../../di/di.dart';
import '../../../../../../model/business/concern/concern_response/concern_response.dart';
import '../../../../../../shared/utils/view_utils.dart';

import '../../../../../../data/repository/remote/landing_page_repository.dart';
import '../../../../../../model/api/base_response.dart';
import '../../../../../../model/business/landing_page/landing_page_call_action_response.dart';

part 'category_call_action_event.dart';
part 'category_call_action_state.dart';

class CategoryCallActionBloc
    extends Bloc<CategoryCallActionEvent, CategoryCallActionState> {
  String currentLandingId = '';
  LandingPageCallActionResponse callActionInfo =
      LandingPageCallActionResponse();
  List<bool> showList = [false, false, false, false, false, false];
  final ConcernRepository concernRepository = getIt.get<ConcernRepository>();
  final LandingPageRepository landingPageRepository =
      getIt.get<LandingPageRepository>();
  ConcernResponse concernResponse = ConcernResponse();

  CategoryCallActionBloc() : super(CategoryCallActionLoading()) {
    on<CategoryCallActionInitEvent>(init);
    on<CategoryCallActionUpdateEvent>(updateCallAction);
    on<CategoryCallActionGetActionEvent>(_onGetAction);
    on<CategoryCallActionCreateActionEvent>(_onCreateAction);
    on<CategoryCallActionGetAllEvent>(_onGetAllAction);
  }

  FutureOr<void> init(CategoryCallActionInitEvent event,
      Emitter<CategoryCallActionState> emit) async {
    currentLandingId = event.landingId;
    ResponseWrapper response =
        await landingPageRepository.getCallAction(landingId: event.landingId);
    if (response.status == ResponseStatus.success) {
      callActionInfo = response.data;
      if (callActionInfo.actions != null) {
        for (int i = 0; i < callActionInfo.actions!.length; i++) {
          showList[int.parse(callActionInfo.actions![i])] = true;
        }
      }

      emit(CategoryCallActionInitial(callActionInfo: callActionInfo));
    }
  }

  FutureOr<void> _onGetAction(CategoryCallActionGetActionEvent event,
      Emitter<CategoryCallActionState> emit) {}

  FutureOr<void> _onCreateAction(CategoryCallActionCreateActionEvent event,
      Emitter<CategoryCallActionState> emit) async {
    final response = await concernRepository.createConcern(
      concernResponse: concernResponse,
    );
    if (response.status == ResponseStatus.success) {
      emit(CategoryCallActionCreateSuccessState(
          concernResponse: response.data ?? concernResponse));
    } else {
      emit(CategoryCallActionCreateFailedState());
    }
  }

  FutureOr<void> _onGetAllAction(CategoryCallActionGetAllEvent event,
      Emitter<CategoryCallActionState> emit) async {
    final response = await concernRepository.getAllConcern();
    if (response.status == ResponseStatus.success) {
      emit(CategoryCallActionGetAllSuccessState(
          concernList: response.data ?? []));
    } else {
      emit(CategoryCallActionCreateFailedState());
    }
  }

  FutureOr<void> updateCallAction(CategoryCallActionUpdateEvent event,
      Emitter<CategoryCallActionState> emit) async {
    if (showList[1] == false && showList[2] == false) {
      toastWarning("Cần bật ít nhất 1 trong 2 loại: Email hoặc Số điện thoại");
      return;
    }
    List<String> listAction = [];
    for (int i = 0; i < showList.length; i++) {
      if (showList[i]) {
        listAction.add(i.toString());
      }
    }
    ResponseWrapper response = await landingPageRepository.addCallAction(
        data: {
      "id": callActionInfo.id,
      "landingID": currentLandingId,
      "title": event.title,
      "actionInfor": event.actionInfor,
      "background": callActionInfo.background,
      "actions": listAction
    }..removeWhere((key, value) => value == null || value == ''));
    if (response.status == ResponseStatus.success) {
      callActionInfo = response.data;
      for (int i = 0; i < callActionInfo.actions!.length; i++) {
        showList[int.parse(callActionInfo.actions![i])] = true;
      }
      emit(CategoryCallActionInitial(callActionInfo: callActionInfo));
    }
  }
}
