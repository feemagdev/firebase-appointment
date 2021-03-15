import 'dart:async';

import 'package:appointment/Models/business_client_model.dart';
import 'package:appointment/Repositories/business_client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_business_client_event.dart';
part 'update_business_client_state.dart';

class UpdateBusinessClientBloc
    extends Bloc<UpdateBusinessClientEvent, UpdateBusinessClientState> {
  final BusinessClient bClient;
  UpdateBusinessClientBloc({@required this.bClient})
      : super(UpdateBusinessClientInitial());

  @override
  Stream<UpdateBusinessClientState> mapEventToState(
    UpdateBusinessClientEvent event,
  ) async* {
    if (event is UpdateBusinessClientButtonEvent) {
      yield UpdateBusinessClientLoadingState();
      Map<String, dynamic> data = {
        'phone': event.bClient.getPhone(),
        'company': event.bClient.getCompany(),
        'contact': event.bClient.getContact(),
        'address': event.bClient.getAddress(),
        'city': event.bClient.getCity(),
        'state': event.bClient.getState(),
        'zip_code': event.bClient.getZipCode(),
      };
      bool check = await BusinessClientRepository.defaultConstructor()
          .updateBusinessClient(data, event.bClient.getBClientID());

      if (check) {
        yield BusinessClientUpdatedSuccessfullyState();
      }
    }
  }
}
