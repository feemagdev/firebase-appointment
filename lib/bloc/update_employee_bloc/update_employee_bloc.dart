import 'dart:async';

import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Repositories/employee_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_employee_event.dart';
part 'update_employee_state.dart';

class UpdateEmployeeBloc
    extends Bloc<UpdateEmployeeEvent, UpdateEmployeeState> {
  final Employee employee;
  UpdateEmployeeBloc({@required this.employee})
      : super(UpdateEmployeeInitial());

  @override
  Stream<UpdateEmployeeState> mapEventToState(
    UpdateEmployeeEvent event,
  ) async* {
    if (event is UpdateEmployeeButtonEvent) {
      yield UpdateEmployeeLoadingState();
      Map<String, dynamic> data = {
        'employee_name': event.employee.getEmployeeName(),
        'employee_phone': event.employee.getEmployeePhone(),
      };
      bool check = await EmployeeRepository.defaultConstructor()
          .updateEmployee(data, employee.getEmployeeID());

      if (check) {
        yield EmployeeUpdatedSuccessfullyState();
      }
    }
  }
}
