import 'dart:async';

import 'package:appointment/Models/business_client_model.dart';
import 'package:appointment/Repositories/business_client_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_business_client_event.dart';
part 'add_business_client_state.dart';

class AddBusinessClientBloc
    extends Bloc<AddBusinessClientEvent, AddBusinessClientState> {
  AddBusinessClientBloc() : super(AddBusinessClientInitial());

  @override
  Stream<AddBusinessClientState> mapEventToState(
    AddBusinessClientEvent event,
  ) async* {
    if (event is AddBusinessClientButtonEvent) {
      yield AddBusinessClientLoadingState();
      Map<String, dynamic> data = {
        'phone': event.phone,
        'company': event.company,
        'contact': event.contact,
        'address': event.address,
        'city': event.city,
        'state': event.state,
        'zip_code': event.zipCode
      };
      BusinessClient bClient =
          await BusinessClientRepository.defaultConstructor()
              .addBusinessClient(data);

      yield BusinessClientAddedSuccessfullyState(bClient: bClient);
    }
  }
}
