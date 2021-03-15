part of 'update_employee_bloc.dart';

@immutable
abstract class UpdateEmployeeEvent {}

class UpdateEmployeeButtonEvent extends UpdateEmployeeEvent {
  final Employee employee;
  UpdateEmployeeButtonEvent({@required this.employee});
}
