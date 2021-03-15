part of 'company_bloc.dart';

@immutable
abstract class CompanyState {}

class CompanyInitial extends CompanyState {}

class CompanyLoadingState extends CompanyState {}

class CompanySavedSuccessfullyState extends CompanyState {}

class CompanyNotRegisteredState extends CompanyState {}

class GetCompanyState extends CompanyState {
  final Company company;
  GetCompanyState({@required this.company});
}
