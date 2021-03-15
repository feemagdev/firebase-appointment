part of 'add_personal_appointment_bloc.dart';

@immutable
abstract class AddPersonalAppointmentEvent {}

class GetEmployeeAndClientDataEvent extends AddPersonalAppointmentEvent {}

class AddPersonalAppointmentButtonEvent extends AddPersonalAppointmentEvent {
  final DateTime dateAdded;
  final DateTime appointmentDate;
  final TimeOfDay appointmentTime;
  final Employee employee;
  final PersonalClient client;
  final bool confirmed;

  AddPersonalAppointmentButtonEvent(
      {@required this.appointmentDate,
      @required this.appointmentTime,
      @required this.client,
      @required this.confirmed,
      @required this.dateAdded,
      @required this.employee});
}
