import 'dart:async';

import 'package:appointment/Models/business_appointment_model.dart';
import 'package:appointment/Models/business_client_model.dart';
import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Repositories/business_appointment_repository.dart';
import 'package:appointment/Repositories/business_client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'business_appointment_event.dart';
part 'business_appointment_state.dart';

class BusinessAppointmentBloc
    extends Bloc<BusinessAppointmentEvent, BusinessAppointmentState> {
  final List<Employee> employees;
  BusinessAppointmentBloc({@required this.employees})
      : super(BusinessAppointmentInitial());

  @override
  Stream<BusinessAppointmentState> mapEventToState(
    BusinessAppointmentEvent event,
  ) async* {
    if (event is GetBusinessAppointmentDataEvent) {
      yield BusinessAppointmentLoadingState();
      List<BusinessAppointment> appointments =
          await getBusinessAppointment(event.date, event.employeeID);

      if (appointments != null) {
        List<BusinessClient> clients = [];
        clients = await getBusinessClient(appointments);
        yield GetBusinessAppointmentDataState(
            bAppointments: appointments, bClients: clients);
      } else {
        yield NoBusinessAppointmentBookedState();
      }
    } else if (event is DeleteBusinessAppointmentEvent) {
      yield BusinessAppointmentLoadingState();
      bool check = await BusinessAppointmentRepository.defaultConstructor()
          .deleteAppointment(event.appointmentID);
      if (check) {
        yield BusinessAppointmentDeletedSuccessfully();
      }
    }
  }

  DateTime changeDate(DateTime appointmentDate) {
    return DateTime(appointmentDate.year, appointmentDate.month,
        appointmentDate.day, 12, 0, 0, 0, 0);
  }

  Future<List<BusinessAppointment>> getBusinessAppointment(
      DateTime date, String employeeID) async {
    return await BusinessAppointmentRepository.defaultConstructor()
        .getEmployeeBusinessAppointments(changeDate(date), employeeID);
  }

  Future<List<BusinessClient>> getBusinessClient(
      List<BusinessAppointment> appointments) async {
    List<BusinessClient> clients = [];
    await Future.forEach(appointments, (BusinessAppointment appointment) async {
      print(appointment.getBClientID());
      clients.add(await BusinessClientRepository.defaultConstructor()
          .getBusinessClientData(appointment.getBClientID()));
    });
    return clients;
  }
}
