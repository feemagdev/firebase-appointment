part of 'add_personal_client_bloc.dart';

@immutable
abstract class AddPersonalClientEvent {}

class AddPersonalClientButtonEvent extends AddPersonalClientEvent {
  final String phone;
  final String lastName;
  final String firstName;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  AddPersonalClientButtonEvent(
      {@required this.address,
      @required this.city,
      @required this.firstName,
      @required this.lastName,
      @required this.phone,
      @required this.state,
      @required this.zipCode});
}
