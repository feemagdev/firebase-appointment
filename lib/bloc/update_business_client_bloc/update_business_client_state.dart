part of 'update_business_client_bloc.dart';

@immutable
abstract class UpdateBusinessClientState {}

class UpdateBusinessClientInitial extends UpdateBusinessClientState {}

class BusinessClientUpdatedSuccessfullyState extends UpdateBusinessClientState {
}

class UpdateBusinessClientLoadingState extends UpdateBusinessClientState {}
