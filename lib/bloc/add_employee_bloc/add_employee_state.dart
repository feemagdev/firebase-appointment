part of 'add_employee_bloc.dart';

@immutable
abstract class AddEmployeeState {}

class AddEmployeeInitial extends AddEmployeeState {}

class AddEmployeeLoadingState extends AddEmployeeState {}

class EmployeeAddedSuccessfullyState extends AddEmployeeState {}
