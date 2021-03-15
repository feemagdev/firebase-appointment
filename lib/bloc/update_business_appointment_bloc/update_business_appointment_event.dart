part of 'update_business_appointment_bloc.dart';

@immutable
abstract class UpdateBusinessAppointmentEvent {}

class GetEmployeeAndClientDataEvent extends UpdateBusinessAppointmentEvent {}

class UpdateBusinessAppointmentButtonEvent
    extends UpdateBusinessAppointmentEvent {
  final BusinessAppointment oldBAppointment;
  UpdateBusinessAppointmentButtonEvent({@required this.oldBAppointment});
}
