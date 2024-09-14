// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/repository/local/local_data_access.dart';
import '../../../../data/repository/remote/repository.dart';
import '../../../../di/di.dart';
import '../../../../model/api/base_response.dart';
import '../../../../model/notification/notification_category_response.dart';
import '../../../../model/notification/notification_detail_response.dart';
import '../../../../model/notification/notification_info_response.dart';
import '../../../../services/notification/notification_contract.dart';

part 'noti_event.dart';
part 'noti_state.dart';

class ManageNotiBloc extends Bloc<ManageNotiEvent, ManageNotiState> {
  final NotificationRepository _notificationRepository = getIt.get();
  final NotificationServiceContract _notificationServiceContract = getIt.get();
  final LocalDataAccess _localDataAccess = getIt.get();

  /// is the first time this current user info is called
  bool isFirstTimeGetCurrentInfo = true;

  ManageNotiBloc() : super(ManageNotiInit()) {
    on<NotificationGetNotSeenCountEvent>(_onGetNotSeenCountEvent);
    on<NotificationGetAllCategoriesEvent>(_onGetAllCategories);
    on<NotificationGetAllEvent>(_onGetAllNotifications);
    on<NotificationInitialEvent>(_onInitial);
    on<NotificationRegisterFCMTokenEvent>(_onRegisterFCMToken);
    on<NotificationDisposeEvent>(_onDispose);
    on<NotificationReceiveListEvent>(_onReceiveList);
    on<NotificationReceivetNotSeenCountEvent>(_onReceiveNotiNotSeenCount);
    on<NotificationUpdateSeenNotificationEvent>(_onUpdateSeen);
    on<NotificationReceivetUpdateSeenEvent>(_onReceiveUpdateSeen);
    on<NotificationReceivetNewMessageEvent>(_onReceiveNewMessage);
  }

  // FutureOr<void> _initNoti(
  //     ManageNotiEvent event, Emitter<ManageNotiState> emit) async {
  //   var hubConnection = _notificationServiceContract.initialize();
  //   NotificationsResponse? response;
  //   List<Notifications> listNotificationsSystem = [];
  //   List<Notifications> listNotificationsIndividual = [];

  //   hubConnection.on("notify-list", (arguments) {
  //     log(arguments.toString());
  //     response =
  //         NotificationsResponse.fromJson(arguments![0] as Map<String, dynamic>);
  //     if (response != null)
  //       for (var i in response!.data!) {
  //         if (
  //             // i.notificationTypeId == "5b0df7a3-3e79-429e-b757-9280800e630f" ||
  //             i.notificationTypeId == "b8cec929-c4af-4775-9033-b47bfdf9bea2") {
  //           listNotificationsSystem.add(i);
  //         } else {
  //           listNotificationsIndividual.add(i);
  //         }
  //       }
  //   });
  //   if (hubConnection.connectionId != null) {
  //     try {
  //       await hubConnection.invoke("getNotificationByUser", args: <Object>[
  //         {
  //           "page": 0,
  //           "pageSize": 100, /* "notificationTypeId": ""*/
  //         },
  //         hubConnection.connectionId!
  //       ]);
  //     } catch (e) {
  //       log(e.toString());
  //     }
  //   }
  //   emit(NotiSuccess(listNotificationsSystem, listNotificationsIndividual));
  // }

  FutureOr<void> _onGetAllCategories(NotificationGetAllCategoriesEvent event,
      Emitter<ManageNotiState> emit) async {
    final response = await _notificationRepository.getAllCategories();
    if (response.status == ResponseStatus.success) {
      emit(NotificationGetAllCategoriesSuccessState(response.data ?? []));
    } else {
      emit(NotificationGetAllCategoriesFailedState());
    }
  }

  FutureOr<void> _onGetAllNotifications(
      NotificationGetAllEvent event, Emitter<ManageNotiState> emit) async {
    // final response = await _notificationRepository.getAllNotification(
    //   pageNum: event.pageNum,
    //   pageSize: event.pageSize,
    //   categoryId: event.categoryId,
    // );

    await _notificationServiceContract.getAllNotification(
      event.categoryId ?? '',
      page: event.pageNum,
      pageSize: event.pageSize,
    );
  }

  FutureOr<void> _onDispose(
      NotificationDisposeEvent event, Emitter<ManageNotiState> emit) async {
    _notificationServiceContract.dispose();
  }

  FutureOr<void> _onInitial(
      NotificationInitialEvent event, Emitter<ManageNotiState> emit) async {
    // init notification service
    if (isFirstTimeGetCurrentInfo) {
      final initializeSuccess = await _notificationServiceContract.initialize();
      if (initializeSuccess) {
        isFirstTimeGetCurrentInfo = false;
        emit(NotificationInitializeSuccessState());
      }
    }
  }

  FutureOr<void> _onGetNotSeenCountEvent(NotificationGetNotSeenCountEvent event,
      Emitter<ManageNotiState> emit) async {
    log('get not seen count in bloc: ${event.typeId}');
    await _notificationServiceContract.getNotificationCountNotSeenByUser(
        event.typeId == 'all' ? null : event.typeId);
    // if (response.status == ResponseStatus.success) {
    //   emit(NotificationGetNotSeenCountSuccessState(response.data ?? 0));
    // } else {
    //   emit(NotificationGetAllFailedState());
    // }
  }

  FutureOr<void> _onReceiveList(
      NotificationReceiveListEvent event, Emitter<ManageNotiState> emit) {
    emit(NotificationGetAllSuccessState(
      event.notifications,
      event.type,
    ));
  }

  FutureOr<void> _onReceiveNotiNotSeenCount(
      NotificationReceivetNotSeenCountEvent event,
      Emitter<ManageNotiState> emit) {
    emit(NotificationGetNotSeenCountSuccessState(event.count, event.type));
  }

  FutureOr<void> _onUpdateSeen(NotificationUpdateSeenNotificationEvent event,
      Emitter<ManageNotiState> emit) async {
    _notificationServiceContract.updateSeenOneNotification(id: event.id);
  }

  FutureOr<void> _onReceiveUpdateSeen(NotificationReceivetUpdateSeenEvent event,
      Emitter<ManageNotiState> emit) {
    emit(NotificationReceivetUpdateSeenState());
  }

  FutureOr<void> _onReceiveNewMessage(NotificationReceivetNewMessageEvent event,
      Emitter<ManageNotiState> emit) {
    emit(NotificationReceiveNewMessageSuccessState(
        event.notificationDetailResponse));
  }

  FutureOr<void> _onRegisterFCMToken(NotificationRegisterFCMTokenEvent event,
      Emitter<ManageNotiState> emit) async {
    if (_localDataAccess.getIsRegisterFCMToken()) return;
    final response = await _notificationRepository.registerFCMToken();
    if (response.status == ResponseStatus.success) {
      _localDataAccess.setIsRegisterFCMToken(true);
    } else {
      _localDataAccess.setIsRegisterFCMToken(false);
    }
  }
}
