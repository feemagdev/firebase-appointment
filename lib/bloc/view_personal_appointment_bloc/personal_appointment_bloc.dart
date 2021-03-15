import 'dart:async';

import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Models/personal_appointment_model.dart';
import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/repositories/personal_appointment_repository.dart';
import 'package:appointment/repositories/personal_client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'personal_appointment_event.dart';
part 'personal_appointment_state.dart';

class PersonalAppointmentBloc
    extends Bloc<PersonalAppointmentEvent, PersonalAppointmentState> {
  final List<Employee> employees;
  PersonalAppointmentBloc({@required this.employees})
      : super(PersonalAppointmentInitial(employees: employees));

  @override
  Stream<PersonalAppointmentState> mapEventToState(
    PersonalAppointmentEvent event,
  ) async* {
    if (event is GetPersonalAppointmentDataEvent) {
      yield PersonalAppointmentLoadingState();
      List<PersonalAppointment> appointments =
          await getPersonalAppointment(event.date, event.employeeID);

      if (appointments != null) {
        List<PersonalClient> clients = [];
        clients = await getPersonalClient(appointments);
        yield GetPersonalAppointmentDataState(
            appointments: appointments, clients: clients);
      } else {
        yield NoPersonalAppointmentBookedState();
      }
    } else if (event is DeletePersonalAppointmentEvent) {
      yield PersonalAppointmentLoadingState();
      bool check = await PersonalAppointmentRepository.defaultConstructor()
          .deleteAppointment(event.appointmentID);
      if (check) {
        yield PersonalAppointmentDeletedSuccessfully();
      }
    }
  }

  DateTime changeDate(DateTime appointmentDate) {
    return DateTime(appointmentDate.year, appointmentDate.month,
        appointmentDate.day, 12, 0, 0, 0, 0);
  }

  Future<List<PersonalAppointment>> getPersonalAppointment(
      DateTime date, String employeeID) async {
    return await PersonalAppointmentRepository.defaultConstructor()
        .getEmployeePersonalAppointments(changeDate(date), employeeID);
  }

  Future<List<PersonalClient>> getPersonalClient(
      List<PersonalAppointment> appointments) async {
    List<PersonalClient> clients = [];
    await Future.forEach(appointments, (PersonalAppointment appointment) async {
      clients.add(await PersonalClientRepository.defaultConstructor()
          .getClientData(appointment.getClientID()));
    });
    return clients;
  }
}
