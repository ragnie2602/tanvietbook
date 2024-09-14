import '../../../../model/phonebook/saved_contact_response.dart';

abstract class SavedContactsEvent {}

class SavedContactsEventInit extends SavedContactsEvent {
  final int pageNum;
  final int pageSize;

  SavedContactsEventInit({required this.pageNum, required this.pageSize});
}

class SavedContactsEventSearch extends SavedContactsEvent {
  String keyword;
  SavedContactsEventSearch({required this.keyword});
}

class SavedContactsEventDelete extends SavedContactsEvent {
  SavedContactResponseData savedContacts;
  SavedContactsEventDelete({required this.savedContacts});
}
