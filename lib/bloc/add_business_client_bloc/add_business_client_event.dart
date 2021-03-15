part of 'add_business_client_bloc.dart';

@immutable
abstract class AddBusinessClientEvent {}

class AddBusinessClientButtonEvent extends AddBusinessClientEvent {
  final String phone;
  final String company;
  final String contact;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  AddBusinessClientButtonEvent(
      {@required this.address,
      @required this.city,
      @required this.company,
      @required this.contact,
      @required this.phone,
      @required this.state,
      @required this.zipCode});
}
