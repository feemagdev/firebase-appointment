import 'package:appointment/Models/business_appointment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessAppointmentRepository {
  BusinessAppointmentRepository.defaultConstructor();

  Future<bool> createAppointment(Map data) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentReference reference =
        await dbReference.collection('business_appointment').add(data);
    if (reference.id.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<BusinessAppointment>> getEmployeeBusinessAppointments(
      DateTime date, String employeeID) async {
    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await dbReference
        .collection('business_appointment')
        .where('appointment_date', isEqualTo: date)
        .where('employee_id', isEqualTo: employeeID)
        .orderBy('appointment_time')
        .get();
    if (snapshot.size == 0) {
      return null;
    } else {
      List<BusinessAppointment> appointments = [];
      snapshot.docs.forEach((element) {
        appointments
            .add(BusinessAppointment.fromMap(element.data(), element.id));
      });
      return appointments;
    }
  }

  Future<bool> updateAppointment(Map data, String bAppointmentID) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference
        .collection('business_appointment')
        .doc(bAppointmentID)
        .update(data);
    return true;
  }

  Future<bool> deleteAppointment(String bAppointmentID) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference
        .collection('business_appointment')
        .doc(bAppointmentID)
        .delete();
    return true;
  }
}
