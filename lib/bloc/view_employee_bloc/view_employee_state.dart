part of 'view_employee_bloc.dart';

@immutable
abstract class ViewEmployeeState {}

class ViewEmployeeInitial extends ViewEmployeeState {}

class GetEmployeesListState extends ViewEmployeeState {
  final List<Employee> employeesList;
  GetEmployeesListState({@required this.employeesList});
}

class NoEmployeeFoundState extends ViewEmployeeState {}

class ViewEmployeeLoadingState extends ViewEmployeeState {}
