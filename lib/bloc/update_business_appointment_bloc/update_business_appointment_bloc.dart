import 'dart:async';

import 'package:appointment/Models/business_appointment_model.dart';
import 'package:appointment/Models/business_client_model.dart';
import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Repositories/business_appointment_repository.dart';
import 'package:appointment/Repositories/business_client_repository.dart';
import 'package:appointment/Repositories/employee_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'update_business_appointment_event.dart';
part 'update_business_appointment_state.dart';

class UpdateBusinessAppointmentBloc extends Bloc<UpdateBusinessAppointmentEvent,
    UpdateBusinessAppointmentState> {
  final BusinessAppointment oldBAppointment;
  final BusinessClient oldBClient;
  final Employee oldEmployee;
  UpdateBusinessAppointmentBloc(
      {@required this.oldEmployee,
      @required this.oldBAppointment,
      @required this.oldBClient})
      : super(UpdateBusinessAppointmentInitial());

  @override
  Stream<UpdateBusinessAppointmentState> mapEventToState(
    UpdateBusinessAppointmentEvent event,
  ) async* {
    if (event is GetEmployeeAndClientDataEvent) {
      yield UpdateBusinessAppointmentLoadingState();
      List<Employee> employeesList = [];
      List<BusinessClient> bClientsList = [];
      employeesList =
          await EmployeeRepository.defaultConstructor().getEmployeesList();

      bClientsList = await BusinessClientRepository.defaultConstructor()
          .getBusinessClientsList();

      yield GetEmployeeAndClientDataState(
          bClients: bClientsList, employees: employeesList);
    } else if (event is UpdateBusinessAppointmentButtonEvent) {
      yield UpdateBusinessAppointmentLoadingState();
      Map<String, dynamic> data = {
        'date_added': event.oldBAppointment.getDateAdded(),
        'appointment_date':
            _changeDate(event.oldBAppointment.getAppointmentDate()),
        'appointment_time': _changeTime(TimeOfDay(
            hour: event.oldBAppointment.getAppointmentTime().hour,
            minute: event.oldBAppointment.getAppointmentTime().minute)),
        'bclient_id': event.oldBAppointment.getBClientID(),
        'employee_id': event.oldBAppointment.getEmployeeID(),
        'confirmed': event.oldBAppointment.getStatus()
      };
      bool check = await BusinessAppointmentRepository.defaultConstructor()
          .updateAppointment(data, oldBAppointment.getBAppointmentID());
      if (check) {
        yield BusinessAppointmentUpdatedSuccessfullyState();
      }
    }
  }

  DateTime _changeDate(DateTime appointmentDate) {
    return DateTime(appointmentDate.year, appointmentDate.month,
        appointmentDate.day, 12, 0, 0, 0, 0);
  }

  DateTime _changeTime(TimeOfDay appointmentTime) {
    return DateTime(
        2020, 1, 1, appointmentTime.hour, appointmentTime.minute, 0, 0, 0);
  }
}
