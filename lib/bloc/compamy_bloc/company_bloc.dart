import 'dart:async';

import 'package:appointment/Models/company_model.dart';
import 'package:appointment/Repositories/company_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'company_event.dart';
part 'company_state.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super(CompanyInitial());

  @override
  Stream<CompanyState> mapEventToState(
    CompanyEvent event,
  ) async* {
    if (event is SaveCompanyEvent) {
      yield CompanyLoadingState();
      bool check = await CompanyRepository.defaultConstructor()
          .saveCompanyDetails(event.company.toMap(), event.company.id);
      if (check) {
        yield CompanySavedSuccessfullyState();
      }
    } else if (event is GetCompanyEvent) {
      Company company =
          await CompanyRepository.defaultConstructor().getCompanyDetails();

      if (company == null) {
        yield CompanyNotRegisteredState();
      } else {
        yield GetCompanyState(company: company);
      }
    }
  }
}
