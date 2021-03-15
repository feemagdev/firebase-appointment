part of 'update_personal_client_bloc.dart';

@immutable
abstract class UpdatePersonalClientEvent {}

class UpdatePersonalClientButtonEvent extends UpdatePersonalClientEvent {
  final PersonalClient client;
  UpdatePersonalClientButtonEvent({@required this.client});
}
