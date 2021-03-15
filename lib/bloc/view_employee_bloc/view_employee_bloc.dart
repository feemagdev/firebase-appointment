import 'dart:async';

import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Repositories/employee_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'view_employee_event.dart';
part 'view_employee_state.dart';

class ViewEmployeeBloc extends Bloc<ViewEmployeeEvent, ViewEmployeeState> {
  ViewEmployeeBloc() : super(ViewEmployeeInitial());

  @override
  Stream<ViewEmployeeState> mapEventToState(
    ViewEmployeeEvent event,
  ) async* {
    if (event is GetEmployeesListEvent) {
      yield ViewEmployeeLoadingState();
      List<Employee> employees = [];
      employees =
          await EmployeeRepository.defaultConstructor().getEmployeesList();
      if (employees == null) {
        yield NoEmployeeFoundState();
      } else {
        yield GetEmployeesListState(employeesList: employees);
      }
    }
  }
}
