part of 'add_business_client_bloc.dart';

@immutable
abstract class AddBusinessClientState {}

class AddBusinessClientInitial extends AddBusinessClientState {}

class BusinessClientAddedSuccessfullyState extends AddBusinessClientState {
  final BusinessClient bClient;
  BusinessClientAddedSuccessfullyState({@required this.bClient});
}

class AddBusinessClientLoadingState extends AddBusinessClientState {}
