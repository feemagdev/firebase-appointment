part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class PersonalAppointmentScreenNavigationEvent extends DashboardEvent {}

class BusinessAppointmentScreenNavigationEvent extends DashboardEvent {}

class GetCompanyDetailEvent extends DashboardEvent {}
