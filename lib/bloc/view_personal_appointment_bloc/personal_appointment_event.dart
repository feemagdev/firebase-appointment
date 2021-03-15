part of 'personal_appointment_bloc.dart';

@immutable
abstract class PersonalAppointmentEvent {}

class GetPersonalAppointmentDataEvent extends PersonalAppointmentEvent {
  final String employeeID;
  final DateTime date;
  GetPersonalAppointmentDataEvent(
      {@required this.employeeID, @required this.date});
}

class DeletePersonalAppointmentEvent extends PersonalAppointmentEvent {
  final String appointmentID;

  DeletePersonalAppointmentEvent({@required this.appointmentID});
}
