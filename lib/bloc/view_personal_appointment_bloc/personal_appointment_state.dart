part of 'personal_appointment_bloc.dart';

@immutable
abstract class PersonalAppointmentState {}

class PersonalAppointmentInitial extends PersonalAppointmentState {
  final List<Employee> employees;
  PersonalAppointmentInitial({@required this.employees});
}

class GetPersonalAppointmentDataState extends PersonalAppointmentState {
  final List<PersonalClient> clients;
  final List<PersonalAppointment> appointments;
  GetPersonalAppointmentDataState(
      {@required this.appointments, @required this.clients});
}

class PersonalAppointmentLoadingState extends PersonalAppointmentState {}

class NoPersonalAppointmentBookedState extends PersonalAppointmentState {}

class PersonalAppointmentDeletedSuccessfully extends PersonalAppointmentState {}
