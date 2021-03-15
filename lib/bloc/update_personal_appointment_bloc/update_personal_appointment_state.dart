part of 'update_personal_appointment_bloc.dart';

@immutable
abstract class UpdatePersonalAppointmentState {}

class UpdatePersonalAppointmentInitial extends UpdatePersonalAppointmentState {}

class PersonalAppointmentUpdatedSuccessfullyState
    extends UpdatePersonalAppointmentState {}

class UpdatePersonalAppointmentLoadingState
    extends UpdatePersonalAppointmentState {}

class GetEmployeeAndClientDataState extends UpdatePersonalAppointmentState {
  final List<Employee> employees;
  final List<PersonalClient> clients;
  GetEmployeeAndClientDataState(
      {@required this.clients, @required this.employees});
}
