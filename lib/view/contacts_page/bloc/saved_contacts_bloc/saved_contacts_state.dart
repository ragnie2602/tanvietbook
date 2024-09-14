import '../../../../model/phonebook/saved_contact_response.dart';

abstract class SavedContactsState {}

class SavedContactsStateDisplay implements SavedContactsState {
  List<SavedContactResponseData> savedContactsDisplay;

  SavedContactsStateDisplay({required this.savedContactsDisplay});
}

class SavedContactsStateFail extends SavedContactsState {}

class SavedContactsStateLoading extends SavedContactsState {}
