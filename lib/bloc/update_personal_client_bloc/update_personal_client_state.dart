part of 'update_personal_client_bloc.dart';

@immutable
abstract class UpdatePersonalClientState {}

class UpdatePersonalClientInitial extends UpdatePersonalClientState {
  final PersonalClient client;
  UpdatePersonalClientInitial({@required this.client});
}

class PersonalClientUpdatedSuccessfullyState extends UpdatePersonalClientState {
}

class UpdatePersonalClientLoadingState extends UpdatePersonalClientState {}
