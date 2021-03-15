import 'package:appointment/Models/personal_client_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalClientRepository {
  PersonalClientRepository.defaultConstructor();
  Future<PersonalClient> addClient(Map data) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentReference reference =
        await dbReference.collection('client').add(data);
    return await getClientData(reference.id);
  }

  Future<PersonalClient> getClientData(String clientID) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbReference.collection('client').doc(clientID).get();
    return PersonalClient.fromMap(snapshot.data(), snapshot.id);
  }

  Future<List<PersonalClient>> getClientsList() async {
    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await dbReference.collection('client').get();
    if (snapshot.size == 0) {
      return null;
    } else {
      List<PersonalClient> clients = [];
      snapshot.docs.forEach((element) {
        clients.add(PersonalClient.fromMap(element.data(), element.id));
      });
      return clients;
    }
  }

  Future<bool> updateClient(Map data, String clientID) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference.collection('client').doc(clientID).update(data);
    return true;
  }
}
