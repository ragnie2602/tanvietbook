part of 'contacts_page_bloc.dart';

@immutable
abstract class ContactsPageEvent extends Equatable {}

class ContactsPageInitEvent extends ContactsPageEvent {
  @override
  List<Object?> get props => [];
}

class ContactsPageChangePageEvent extends ContactsPageEvent {
  final int screenIndex;

  ContactsPageChangePageEvent(this.screenIndex);

  @override
  List<Object?> get props => [screenIndex];
}
