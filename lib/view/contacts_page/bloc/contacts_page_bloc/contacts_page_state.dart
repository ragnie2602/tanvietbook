part of 'contacts_page_bloc.dart';

@immutable
abstract class ContactsPageState extends Equatable {}

class ContactsPageInitial extends ContactsPageState {
  final int screenIndex;

  ContactsPageInitial({required this.screenIndex});

  @override
  List<Object?> get props => [screenIndex];
}
