import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'contacts_page_event.dart';
part 'contacts_page_state.dart';

class ContactsPageBloc extends Bloc<ContactsPageEvent, ContactsPageState> {
  int currentScreen = 0;
  ContactsPageBloc() : super(ContactsPageInitial(screenIndex: 0)) {
    on<ContactsPageEvent>(init);
    on<ContactsPageChangePageEvent>(changePage);
  }

  FutureOr<void> init(
      ContactsPageEvent event, Emitter<ContactsPageState> emit) {}

  FutureOr<void> changePage(
      ContactsPageChangePageEvent event, Emitter<ContactsPageState> emit) {
    emit(ContactsPageInitial(screenIndex: event.screenIndex));
  }
}
