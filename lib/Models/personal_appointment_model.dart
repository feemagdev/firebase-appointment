class PersonalAppointment {
  String _appointmentID;
  DateTime _dateAdded;
  String _employeeID;
  String _clientID;
  DateTime _appointmentDate;
  DateTime _appointmentTime;
  bool _confirmed;

  PersonalAppointment.fromMap(Map snapshot, String appointmentID)
      : _appointmentID = appointmentID,
        _dateAdded = snapshot['date_added'].toDate(),
        _employeeID = snapshot['employee_id'],
        _clientID = snapshot['client_id'],
        _appointmentDate = snapshot['appointment_date'].toDate(),
        _appointmentTime = snapshot['appointment_time'].toDate(),
        _confirmed = snapshot['confirmed'];

  String getAppointmentID() {
    return _appointmentID;
  }

  DateTime getDateAdded() {
    return _dateAdded;
  }

  String getEmployeeID() {
    return _employeeID;
  }

  String getClientID() {
    return _clientID;
  }

  DateTime getAppointmentDate() {
    return _appointmentDate;
  }

  DateTime getAppointmentTime() {
    return _appointmentTime;
  }

  bool getStatus() {
    return _confirmed;
  }

  void setAppointmentDate(DateTime date) {
    _appointmentDate = date;
  }

  void setAppointmentTime(DateTime time) {
    _appointmentTime = time;
  }

  void setStatus(bool status) {
    _confirmed = status;
  }

  void setClientID(String clientID) {
    _clientID = clientID;
  }

  void setEmployeeID(String employeeID) {
    _employeeID = employeeID;
  }

  void setDateAdded(DateTime date) {
    _dateAdded = date;
  }
}
