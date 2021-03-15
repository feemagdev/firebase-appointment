part of 'add_business_appointment_bloc.dart';

@immutable
abstract class AddBusinessAppointmentState {}

class AddBusinessAppointmentInitial extends AddBusinessAppointmentState {}

class BusinessAppointmentAddedSuccessfullyState
    extends AddBusinessAppointmentState {}

class AddBusinessAppointmentLoadingState extends AddBusinessAppointmentState {}

class GetEmployeeAndClientDataState extends AddBusinessAppointmentState {
  final List<Employee> employees;
  final List<BusinessClient> bClients;
  GetEmployeeAndClientDataState(
      {@required this.bClients, @required this.employees});
}

class BusinessAppointmentAddedFailureState extends AddBusinessAppointmentState {
}

class BusinessAppointmentValidationErrorState
    extends AddBusinessAppointmentState {
  final String validation;
  BusinessAppointmentValidationErrorState({@required this.validation});
}
