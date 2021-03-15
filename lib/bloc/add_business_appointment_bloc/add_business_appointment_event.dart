part of 'add_business_appointment_bloc.dart';

@immutable
abstract class AddBusinessAppointmentEvent {}

class GetEmployeeAndClientDataEvent extends AddBusinessAppointmentEvent {}

class AddBusinessAppointmentButtonEvent extends AddBusinessAppointmentEvent {
  final DateTime dateAdded;
  final DateTime bAppointmentDate;
  final TimeOfDay bAppointmentTime;
  final Employee employee;
  final BusinessClient bClient;
  final bool confirmed;

  AddBusinessAppointmentButtonEvent(
      {@required this.bAppointmentDate,
      @required this.bAppointmentTime,
      @required this.bClient,
      @required this.confirmed,
      @required this.dateAdded,
      @required this.employee});
}
