import 'package:appointment/Models/business_client_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessClientRepository {
  BusinessClientRepository.defaultConstructor();
  Future<BusinessClient> addBusinessClient(Map data) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentReference reference =
        await dbReference.collection('business_client').add(data);
    return await getBusinessClientData(reference.id);
  }

  Future<BusinessClient> getBusinessClientData(String bClientID) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbReference.collection('business_client').doc(bClientID).get();
    print("dara");
    print(snapshot.data());
    return BusinessClient.fromMap(snapshot.data(), snapshot.id);
  }

  Future<List<BusinessClient>> getBusinessClientsList() async {
    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await dbReference.collection('business_client').get();
    if (snapshot.size == 0) {
      return null;
    } else {
      List<BusinessClient> bClients = [];
      snapshot.docs.forEach((element) {
        bClients.add(BusinessClient.fromMap(element.data(), element.id));
      });
      return bClients;
    }
  }

  Future<bool> updateBusinessClient(Map data, String bClientID) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference.collection('business_client').doc(bClientID).update(data);
    return true;
  }
}
