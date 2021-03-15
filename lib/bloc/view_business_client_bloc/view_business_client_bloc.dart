import 'dart:async';

import 'package:appointment/Models/business_client_model.dart';
import 'package:appointment/Repositories/business_client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'view_business_client_event.dart';
part 'view_business_client_state.dart';

class ViewBusinessClientBloc
    extends Bloc<ViewBusinessClientEvent, ViewBusinessClientState> {
  ViewBusinessClientBloc() : super(ViewBusinessClientInitial());

  @override
  Stream<ViewBusinessClientState> mapEventToState(
    ViewBusinessClientEvent event,
  ) async* {
    if (event is GetBusinessClientListEvent) {
      yield ViewBusinessClientLoadingState();
      List<BusinessClient> bClients = [];
      bClients = await BusinessClientRepository.defaultConstructor()
          .getBusinessClientsList();
      if (bClients == null || bClients.isEmpty) {
        yield NoBusinessClientFoundState();
      } else {
        yield GetBusinessClientListState(bClientList: bClients);
      }
    } else if (event is BClientSearchingEvent) {
      List<BusinessClient> bClientList = event.bClientList;
      List<BusinessClient> filtered = [];
      String string = event.query;
      bClientList.forEach((element) {
        if (element.getCompany().toLowerCase().contains(string.toLowerCase()) ||
            element.getPhone().toLowerCase().contains(string.toLowerCase())) {
          filtered.add(element);
        }
      });

      yield BusinessClientSearchingState(
          filteredList: filtered, bClientList: bClientList);
    } else if (event is ViewSelectedBusinessClientEvent) {
      yield BusinessClientSelectedState(bClient: event.bClient);
    }
  }
}
