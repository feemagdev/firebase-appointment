class Employee {
  String _employeeID;
  String _employeeName;
  String _employeePhone;

  Employee.fromMap(Map snapshot, String employeeID)
      : _employeeID = employeeID,
        _employeeName = snapshot['employee_name'],
        _employeePhone = snapshot['employee_phone'];

  String getEmployeeID() {
    return _employeeID;
  }

  String getEmployeeName() {
    return _employeeName;
  }

  String getEmployeePhone() {
    return _employeePhone;
  }

  void setEmployeeName(String name) {
    _employeeName = name;
  }

  void setEmployeePhone(String phone) {
    _employeePhone = phone;
  }
}
