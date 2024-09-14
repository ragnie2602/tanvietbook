// ignore_for_file: empty_catches

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../data/repository/remote/phonebook_repository.dart';
import '../../../../di/di.dart';
import '../../../../model/api/base_response.dart';
import '../../../../model/phonebook/suggested_contacts_response.dart';
import '../../../../shared/utils/view_utils.dart';

part 'suggested_contact_event.dart';
part 'suggested_contact_state.dart';

class SuggestedContactBloc
    extends Bloc<SuggestedContactEvent, SuggestedContactState> {
  PhonebookRepository phoneBookRepository = getIt.get<PhonebookRepository>();
  SuggestedContactBloc() : super(SuggestedContactLoading()) {
    on<SuggestedContactInitEvent>(init);
    on<SuggestedContactAddEvent>(addEvent);
  }

  FutureOr<void> init(SuggestedContactInitEvent event,
      Emitter<SuggestedContactState> emit) async {
    var response =
        await phoneBookRepository.suggestPhoneBook(pageNum: 1, pageSize: 15);
    if (response.status == ResponseStatus.success) {
      try {
        SuggestedContactsResponse suggestedContactsResponse = response.data!;
        emit(SuggestedContactInitial(
            suggestedContactsResponse: suggestedContactsResponse));
      } catch (e) {}
    }
  }

  FutureOr<void> addEvent(SuggestedContactAddEvent event,
      Emitter<SuggestedContactState> emit) async {
    var response = await phoneBookRepository.addPhoneBook(
        memberId: event.memberId, username: event.username);
    if (response.status == ResponseStatus.success) {
      toastSuccess('Lưu danh bạ thành công');
      await init(SuggestedContactInitEvent(), emit);
    }
  }
}
