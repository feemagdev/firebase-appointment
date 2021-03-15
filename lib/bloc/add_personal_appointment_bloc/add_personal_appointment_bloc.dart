import 'dart:async';

import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Repositories/personal_client_repository.dart';
import 'package:appointment/Repositories/employee_repository.dart';
import 'package:appointment/Repositories/personal_appointment_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'add_personal_appointment_event.dart';
part 'add_personal_appointment_state.dart';

class AddPersonalAppointmentBloc
    extends Bloc<AddPersonalAppointmentEvent, AddPersonalAppointmentState> {
  AddPersonalAppointmentBloc() : super(AddPersonalAppointmentInitial());

  @override
  Stream<AddPersonalAppointmentState> mapEventToState(
    AddPersonalAppointmentEvent event,
  ) async* {
    if (event is GetEmployeeAndClientDataEvent) {
      yield AddPersonalAppointmentLoadingState();
      List<Employee> employeesList = [];
      List<PersonalClient> clientsList = [];
      employeesList =
          await EmployeeRepository.defaultConstructor().getEmployeesList();

      clientsList =
          await PersonalClientRepository.defaultConstructor().getClientsList();

      yield GetEmployeeAndClientDataState(
          clients: clientsList, employees: employeesList);
    } else if (event is AddPersonalAppointmentButtonEvent) {
      yield AddPersonalAppointmentLoadingState();

      String _validation = _validator(event.appointmentDate,
          event.appointmentTime, event.client, event.employee);

      if (_validation == null) {
        Map<String, dynamic> data = {
          'date_added': event.dateAdded,
          'appointment_date': _changeDate(event.appointmentDate),
          'appointment_time': _changeTime(event.appointmentTime),
          'client_id': event.client.getClientID(),
          'employee_id': event.employee.getEmployeeID(),
          'confirmed': event.confirmed
        };
        bool checkAdded =
            await PersonalAppointmentRepository.defaultConstructor()
                .createAppointment(data);
        if (checkAdded) {
          yield PersonalAppointmentAddedSuccessfullyState();
        } else {
          yield PersonalAppointmentAddedFailureState();
        }
      } else {
        yield PersonalAppointmentValidationErrorState(validation: _validation);
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

  String _validator(DateTime bAppointmentDate, TimeOfDay bAppointmentTime,
      PersonalClient bClient, Employee employee) {
    if (bAppointmentDate == null) {
      return "Please select date of appointment";
    } else if (bAppointmentTime == null) {
      return "Please select time of appointment";
    } else if (bClient == null) {
      return "Please select business client";
    } else if (employee == null) {
      return "Please select employee";
    } else {
      return null;
    }
  }
}
