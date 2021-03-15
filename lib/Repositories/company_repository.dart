import 'package:appointment/Models/company_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyRepository {
  CompanyRepository.defaultConstructor();

  Future<bool> saveCompanyDetails(Map data, String id) async {
    final dbReference = FirebaseFirestore.instance;
    if (id == null) {
      await dbReference.collection('company').add(data);
      return true;
    } else {
      await dbReference.collection('company').doc(id).update(data);
      return true;
    }
  }

  Future<Company> getCompanyDetails() async {
    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await dbReference.collection('company').get();
    if (snapshot.size != 0) {
      print(snapshot.docs.first.data());
      try {
        return Company.fromMap(
            snapshot.docs.first.data(), snapshot.docs.first.id);
      } catch (e) {
        print(e);
        return null;
      }
    } else
      return null;
  }
}
