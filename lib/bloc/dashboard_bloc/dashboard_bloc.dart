import 'dart:async';

import 'package:appointment/Models/company_model.dart';
import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Repositories/company_repository.dart';
import 'package:appointment/Repositories/employee_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial());

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is PersonalAppointmentScreenNavigationEvent) {
      yield DashboardLoadingState();
      List<Employee> employees = await getEmployeesList();
      if (employees == null) {
        employees = [];
        yield PersonalAppointmentScreenNavigationState(employees: employees);
      } else {
        yield PersonalAppointmentScreenNavigationState(employees: employees);
      }
    } else if (event is BusinessAppointmentScreenNavigationEvent) {
      yield DashboardLoadingState();
      List<Employee> employees = await getEmployeesList();
      if (employees == null) {
        employees = [];
        yield BusinessAppointmentScreenNavigationState(employees: employees);
      } else {
        yield BusinessAppointmentScreenNavigationState(employees: employees);
      }
    } else if (event is GetCompanyDetailEvent) {
      yield DashboardLoadingState();
      Company company =
          await CompanyRepository.defaultConstructor().getCompanyDetails();

      yield GetCompanyDetailState(company: company);
    }
  }

  Future<List<Employee>> getEmployeesList() async {
    return await EmployeeRepository.defaultConstructor().getEmployeesList();
  }
}
