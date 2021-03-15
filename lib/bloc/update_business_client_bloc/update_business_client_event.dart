part of 'update_business_client_bloc.dart';

@immutable
abstract class UpdateBusinessClientEvent {}

class UpdateBusinessClientButtonEvent extends UpdateBusinessClientEvent {
  final BusinessClient bClient;
  UpdateBusinessClientButtonEvent({@required this.bClient});
}
