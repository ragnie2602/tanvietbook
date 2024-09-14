import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../model/api/base_response.dart';
import '../../../../model/phonebook/saved_contact_response.dart';
import 'saved_contacts_event.dart';
import 'saved_contacts_state.dart';

import '../../../../data/repository/remote/phonebook_repository.dart';

class SavedContactsBloc extends Bloc<SavedContactsEvent, SavedContactsState> {
  List<SavedContactResponseData> savedContacts = [];
  PhonebookRepository phonebookRepository;

  late PagingController<int, SavedContactResponseData>
      savedContactPagingController = PagingController(firstPageKey: 1);

  SavedContactsBloc({required this.phonebookRepository})
      : super(SavedContactsStateLoading()) {
    on<SavedContactsEventInit>(init);
    on<SavedContactsEventSearch>(search);
    on<SavedContactsEventDelete>(delete);
  }

  FutureOr<void> init(
      SavedContactsEventInit event, Emitter<SavedContactsState> emit) async {
    var response = await phonebookRepository.viewPhoneBook(
        pageNum: event.pageNum, pageSize: event.pageSize);
    if (response.status == ResponseStatus.success) {
      if (response.data!.data!.length < event.pageSize) {
        savedContactPagingController.appendLastPage(response.data!.data!);
      } else {
        savedContactPagingController.appendPage(
            response.data!.data!, event.pageNum + 1);
      }
    }
  }

  FutureOr<void> search(
      SavedContactsEventSearch event, Emitter<SavedContactsState> emit) {
    if (event.keyword.isEmpty) {
      emit(SavedContactsStateDisplay(savedContactsDisplay: savedContacts));
    } else {
      var savedContactsSearch = savedContacts
          .where((element) =>
              element.displayname!
                  .toLowerCase()
                  .contains(event.keyword.toLowerCase()) ||
              element.name!.toLowerCase().contains(event.keyword))
          .toList();
      emit(
        SavedContactsStateDisplay(savedContactsDisplay: savedContactsSearch),
      );
    }
  }

  FutureOr<void> delete(
      SavedContactsEventDelete event, Emitter<SavedContactsState> emit) async {
    var response = await phonebookRepository.deletePhoneBook(
        id: event.savedContacts.id ?? "");
    if (response.status == ResponseStatus.success) {
      savedContacts.remove(event.savedContacts);
      emit(SavedContactsStateDisplay(savedContactsDisplay: savedContacts));
    }
  }
}
