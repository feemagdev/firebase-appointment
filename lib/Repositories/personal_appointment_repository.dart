import 'package:appointment/Models/personal_appointment_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersonalAppointmentRepository {
  PersonalAppointmentRepository.defaultConstructor();

  Future<bool> createAppointment(Map data) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentReference reference =
        await dbReference.collection('personal_appointment').add(data);
    if (reference.id.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<PersonalAppointment>> getEmployeePersonalAppointments(
      DateTime date, String employeeID) async {
    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await dbReference
        .collection('personal_appointment')
        .where('appointment_date', isEqualTo: date)
        .where('employee_id', isEqualTo: employeeID)
        .orderBy('appointment_time')
        .get();
    if (snapshot.size == 0) {
      return null;
    } else {
      List<PersonalAppointment> appointments = [];
      snapshot.docs.forEach((element) {
        appointments
            .add(PersonalAppointment.fromMap(element.data(), element.id));
      });
      return appointments;
    }
  }

  Future<bool> updateAppointment(Map data, String appointmentID) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference
        .collection('personal_appointment')
        .doc(appointmentID)
        .update(data);
    return true;
  }

  Future<bool> deleteAppointment(String appointmentID) async {
    final dbReference = FirebaseFirestore.instance;
    await dbReference
        .collection('personal_appointment')
        .doc(appointmentID)
        .delete();
    return true;
  }
}
