import 'dart:async';

import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/Repositories/personal_client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_personal_client_event.dart';
part 'add_personal_client_state.dart';

class AddPersonalClientBloc
    extends Bloc<AddPersonalClientEvent, AddPersonalClientState> {
  AddPersonalClientBloc() : super(AddPersonalClientInitial());

  @override
  Stream<AddPersonalClientState> mapEventToState(
    AddPersonalClientEvent event,
  ) async* {
    if (event is AddPersonalClientButtonEvent) {
      yield AddPersonalClientLoadingState();
      Map<String, dynamic> data = {
        'phone': event.phone,
        'last_name': event.lastName,
        'first_name': event.firstName,
        'address': event.address,
        'city': event.city,
        'state': event.state,
        'zip_code': event.zipCode
      };
      PersonalClient client =
          await PersonalClientRepository.defaultConstructor().addClient(data);

      yield PersonalClientAddedSuccessfullyState(client: client);
    }
  }
}
