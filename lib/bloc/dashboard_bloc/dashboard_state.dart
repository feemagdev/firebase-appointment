part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class PersonalAppointmentScreenNavigationState extends DashboardState {
  final List<Employee> employees;
  PersonalAppointmentScreenNavigationState({@required this.employees});
}

class BusinessAppointmentScreenNavigationState extends DashboardState {
  final List<Employee> employees;
  BusinessAppointmentScreenNavigationState({@required this.employees});
}

class DashboardLoadingState extends DashboardState {}

class GetCompanyDetailState extends DashboardState {
  final Company company;
  GetCompanyDetailState({@required this.company});
}
