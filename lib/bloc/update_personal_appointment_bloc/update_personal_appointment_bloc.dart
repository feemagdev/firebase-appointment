import 'dart:async';

import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Models/personal_appointment_model.dart';
import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/repositories/employee_repository.dart';
import 'package:appointment/repositories/personal_appointment_repository.dart';
import 'package:appointment/repositories/personal_client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'update_personal_appointment_event.dart';
part 'update_personal_appointment_state.dart';

class UpdatePersonalAppointmentBloc extends Bloc<UpdatePersonalAppointmentEvent,
    UpdatePersonalAppointmentState> {
  final PersonalClient oldClient;
  final Employee oldEmployee;
  final PersonalAppointment oldAppointment;
  UpdatePersonalAppointmentBloc(
      {@required this.oldClient,
      @required this.oldAppointment,
      @required this.oldEmployee})
      : super(UpdatePersonalAppointmentInitial());

  @override
  Stream<UpdatePersonalAppointmentState> mapEventToState(
    UpdatePersonalAppointmentEvent event,
  ) async* {
    if (event is GetEmployeeAndClientDataEvent) {
      yield UpdatePersonalAppointmentLoadingState();
      List<Employee> employeesList = [];
      List<PersonalClient> clientsList = [];
      employeesList =
          await EmployeeRepository.defaultConstructor().getEmployeesList();

      clientsList =
          await PersonalClientRepository.defaultConstructor().getClientsList();

      yield GetEmployeeAndClientDataState(
          clients: clientsList, employees: employeesList);
    } else if (event is UpdatePersonalAppointmentButtonEvent) {
      yield UpdatePersonalAppointmentLoadingState();
      Map<String, dynamic> data = {
        'date_added': event.oldAppointment.getDateAdded(),
        'appointment_date':
            changeDate(event.oldAppointment.getAppointmentDate()),
        'appointment_time': changeTime(TimeOfDay(
            hour: event.oldAppointment.getAppointmentTime().hour,
            minute: event.oldAppointment.getAppointmentTime().minute)),
        'client_id': event.oldAppointment.getClientID(),
        'employee_id': event.oldAppointment.getEmployeeID(),
        'confirmed': event.oldAppointment.getStatus()
      };
      bool check = await PersonalAppointmentRepository.defaultConstructor()
          .updateAppointment(data, oldAppointment.getAppointmentID());
      if (check) {
        yield PersonalAppointmentUpdatedSuccessfullyState();
      }
    }
  }

  DateTime changeDate(DateTime appointmentDate) {
    return DateTime(appointmentDate.year, appointmentDate.month,
        appointmentDate.day, 12, 0, 0, 0, 0);
  }

  DateTime changeTime(TimeOfDay appointmentTime) {
    return DateTime(
        2020, 1, 1, appointmentTime.hour, appointmentTime.minute, 0, 0, 0);
  }
}
