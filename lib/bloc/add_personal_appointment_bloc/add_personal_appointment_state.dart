part of 'add_personal_appointment_bloc.dart';

@immutable
abstract class AddPersonalAppointmentState {}

class AddPersonalAppointmentInitial extends AddPersonalAppointmentState {}

class GetEmployeeAndClientDataState extends AddPersonalAppointmentState {
  final List<Employee> employees;
  final List<PersonalClient> clients;

  GetEmployeeAndClientDataState(
      {@required this.employees, @required this.clients});
}

class AddPersonalAppointmentLoadingState extends AddPersonalAppointmentState {}

class PersonalAppointmentAddedSuccessfullyState
    extends AddPersonalAppointmentState {}

class PersonalAppointmentAddedFailureState extends AddPersonalAppointmentState {
}

class PersonalAppointmentValidationErrorState
    extends AddPersonalAppointmentState {
  final String validation;
  PersonalAppointmentValidationErrorState({@required this.validation});
}
