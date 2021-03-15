part of 'view_business_client_bloc.dart';

@immutable
abstract class ViewBusinessClientEvent {}

class GetBusinessClientListEvent extends ViewBusinessClientEvent {}

class BClientSearchingEvent extends ViewBusinessClientEvent {
  final String query;
  final List<BusinessClient> bClientList;
  BClientSearchingEvent({@required this.bClientList, @required this.query});
}

class ViewSelectedBusinessClientEvent extends ViewBusinessClientEvent {
  final BusinessClient bClient;
  ViewSelectedBusinessClientEvent({@required this.bClient});
}
