part of 'update_employee_bloc.dart';

@immutable
abstract class UpdateEmployeeState {}

class UpdateEmployeeInitial extends UpdateEmployeeState {}

class EmployeeUpdatedSuccessfullyState extends UpdateEmployeeState {}

class UpdateEmployeeLoadingState extends UpdateEmployeeState {}
