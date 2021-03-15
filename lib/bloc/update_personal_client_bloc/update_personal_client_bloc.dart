import 'dart:async';

import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/Repositories/personal_client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_personal_client_event.dart';
part 'update_personal_client_state.dart';

class UpdatePersonalClientBloc
    extends Bloc<UpdatePersonalClientEvent, UpdatePersonalClientState> {
  final PersonalClient client;
  UpdatePersonalClientBloc({@required this.client})
      : super(UpdatePersonalClientInitial(client: client));

  @override
  Stream<UpdatePersonalClientState> mapEventToState(
    UpdatePersonalClientEvent event,
  ) async* {
    if (event is UpdatePersonalClientButtonEvent) {
      yield UpdatePersonalClientLoadingState();
      Map<String, dynamic> data = {
        'phone': event.client.getPhone(),
        'last_name': event.client.getLastName(),
        'first_name': event.client.getFirstName(),
        'address': event.client.getAddress(),
        'city': event.client.getCity(),
        'state': event.client.getState(),
        'zip_code': event.client.getZipCode(),
      };
      bool check = await PersonalClientRepository.defaultConstructor()
          .updateClient(data, event.client.getClientID());

      if (check) {
        yield PersonalClientUpdatedSuccessfullyState();
      }
    }
  }
}
