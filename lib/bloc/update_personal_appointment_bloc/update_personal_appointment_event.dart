part of 'update_personal_appointment_bloc.dart';

@immutable
abstract class UpdatePersonalAppointmentEvent {}

class GetEmployeeAndClientDataEvent extends UpdatePersonalAppointmentEvent {}

class UpdatePersonalAppointmentButtonEvent
    extends UpdatePersonalAppointmentEvent {
  final PersonalAppointment oldAppointment;

  UpdatePersonalAppointmentButtonEvent({@required this.oldAppointment});
}
