import '../../../model/api/base_response.dart';
import '../../../model/phonebook/saved_contact_response.dart';
import '../../../model/phonebook/suggested_contacts_response.dart';

abstract class PhonebookRepository {
  Future<ResponseWrapper<String>> addPhoneBook(
      {required String memberId, String? username});
  Future<ResponseWrapper<String>> updatePhoneBook();
  Future<ResponseWrapper<String>> deletePhoneBook({required String id});
  Future<ResponseWrapper<SavedContactResponse>> viewPhoneBook(
      {String? keyword,
      String? orderBy,
      required int pageNum,
      int pageSize = 15});
  Future<ResponseWrapper<String>> searchPhoneBook();
  Future<ResponseWrapper<SuggestedContactsResponse>> suggestPhoneBook(
      {required int pageNum, int pageSize = 15});
}
