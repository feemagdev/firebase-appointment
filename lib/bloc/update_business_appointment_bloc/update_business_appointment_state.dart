part of 'update_business_appointment_bloc.dart';

@immutable
abstract class UpdateBusinessAppointmentState {}

class UpdateBusinessAppointmentInitial extends UpdateBusinessAppointmentState {}

class BusinessAppointmentUpdatedSuccessfullyState
    extends UpdateBusinessAppointmentState {}

class UpdateBusinessAppointmentLoadingState
    extends UpdateBusinessAppointmentState {}

class GetEmployeeAndClientDataState extends UpdateBusinessAppointmentState {
  final List<Employee> employees;
  final List<BusinessClient> bClients;
  GetEmployeeAndClientDataState(
      {@required this.bClients, @required this.employees});
}
