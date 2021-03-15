part of 'view_business_client_bloc.dart';

@immutable
abstract class ViewBusinessClientState {}

class ViewBusinessClientInitial extends ViewBusinessClientState {}

class BusinessClientSelectedState extends ViewBusinessClientState {
  final BusinessClient bClient;
  BusinessClientSelectedState({@required this.bClient});
}

class BusinessClientSearchingState extends ViewBusinessClientState {
  final List<BusinessClient> bClientList;
  final List<BusinessClient> filteredList;
  BusinessClientSearchingState(
      {@required this.bClientList, @required this.filteredList});
}

class GetBusinessClientListState extends ViewBusinessClientState {
  final List<BusinessClient> bClientList;
  GetBusinessClientListState({@required this.bClientList});
}

class ViewBusinessClientLoadingState extends ViewBusinessClientState {}

class NoBusinessClientFoundState extends ViewBusinessClientState {}
