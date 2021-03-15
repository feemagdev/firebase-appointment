part of 'business_appointment_bloc.dart';

@immutable
abstract class BusinessAppointmentState {}

class BusinessAppointmentInitial extends BusinessAppointmentState {}

class BusinessAppointmentDeletedSuccessfully extends BusinessAppointmentState {}

class GetBusinessAppointmentDataState extends BusinessAppointmentState {
  final List<BusinessAppointment> bAppointments;
  final List<BusinessClient> bClients;

  GetBusinessAppointmentDataState(
      {@required this.bAppointments, @required this.bClients});
}

class NoBusinessAppointmentBookedState extends BusinessAppointmentState {}

class BusinessAppointmentLoadingState extends BusinessAppointmentState {}
