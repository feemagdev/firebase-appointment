import 'package:appointment/Models/employee_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeRepository {
  EmployeeRepository.defaultConstructor();

  Future<Employee> addEmployee(Map map) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentReference reference =
        await dbReference.collection('employee').add(map);

    return await getEmployeeData(reference.id);
  }

  Future<Employee> getEmployeeData(String employeeID) async {
    final dbReference = FirebaseFirestore.instance;
    DocumentSnapshot snapshot =
        await dbReference.collection('employee').doc(employeeID).get();
    return Employee.fromMap(snapshot.data(), snapshot.id);
  }

  Future<List<Employee>> getEmployeesList() async {
    final dbReference = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await dbReference.collection('employee').get();
    if (snapshot.size == 0) {
      return null;
    } else {
      List<Employee> employees = [];
      snapshot.docs.forEach((element) {
        employees.add(Employee.fromMap(element.data(), element.id));
      });
      return employees;
    }
  }

  Future<bool> updateEmployee(Map data, String employeeID) async {
    final dbRefernece = FirebaseFirestore.instance;
    await dbRefernece.collection('employee').doc(employeeID).update(data);
    return true;
  }
}
