part of 'view_personal_client_bloc.dart';

@immutable
abstract class ViewPersonalClientState {}

class ViewPersonalClientInitial extends ViewPersonalClientState {}

class ClientSelectedState extends ViewPersonalClientState {
  final PersonalClient client;
  ClientSelectedState({@required this.client});
}

class ClientSearchingState extends ViewPersonalClientState {
  final List<PersonalClient> clientList;
  final List<PersonalClient> filteredList;

  ClientSearchingState(
      {@required this.clientList, @required this.filteredList});
}

class GetClientListState extends ViewPersonalClientState {
  final List<PersonalClient> clientList;
  GetClientListState({@required this.clientList});
}

class ViewPersonalClientLoadingState extends ViewPersonalClientState {}

class NoClientFoundState extends ViewPersonalClientState {}
