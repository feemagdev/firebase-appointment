import 'dart:async';

import 'package:appointment/Repositories/employee_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_employee_event.dart';
part 'add_employee_state.dart';

class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  AddEmployeeBloc() : super(AddEmployeeInitial());

  @override
  Stream<AddEmployeeState> mapEventToState(
    AddEmployeeEvent event,
  ) async* {
    if (event is AddEmployeeButtonEvent) {
      yield AddEmployeeLoadingState();
      Map<String, dynamic> map = {
        'employee_name': event.name,
        'employee_phone': event.phone
      };
      await EmployeeRepository.defaultConstructor().addEmployee(map);
      yield EmployeeAddedSuccessfullyState();
    }
  }
}
