part of 'company_bloc.dart';

@immutable
abstract class CompanyEvent {}

class SaveCompanyEvent extends CompanyEvent {
  final Company company;
  SaveCompanyEvent({@required this.company});
}

class GetCompanyEvent extends CompanyEvent {}
