part of 'view_personal_client_bloc.dart';

@immutable
abstract class ViewPersonalClientEvent {}

class GetClientListEvent extends ViewPersonalClientEvent {}

class ClientSearchingEvent extends ViewPersonalClientEvent {
  final List<PersonalClient> clientList;
  final String query;

  ClientSearchingEvent({@required this.clientList, @required this.query});
}

class ViewSelectedClientEvent extends ViewPersonalClientEvent {
  final PersonalClient client;
  ViewSelectedClientEvent({@required this.client});
}
