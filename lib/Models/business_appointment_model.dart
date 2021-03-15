class BusinessAppointment {
  String _bAppointmentID;
  DateTime _dateAdded;
  String _employeeID;
  String _bClientID;
  DateTime _appointmentDate;
  DateTime _appointmentTime;
  bool _confirmed;

  BusinessAppointment.fromMap(Map snapshot, String bAppointmentID)
      : _bAppointmentID = bAppointmentID,
        _dateAdded = snapshot['date_added'].toDate(),
        _employeeID = snapshot['employee_id'],
        _bClientID = snapshot['bclient_id'],
        _appointmentDate = snapshot['appointment_date'].toDate(),
        _appointmentTime = snapshot['appointment_time'].toDate(),
        _confirmed = snapshot['confirmed'];

  String getBAppointmentID() {
    return _bAppointmentID;
  }

  DateTime getDateAdded() {
    return _dateAdded;
  }

  String getEmployeeID() {
    return _employeeID;
  }

  String getBClientID() {
    return _bClientID;
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

  void setBClientID(String bClientID) {
    _bClientID = bClientID;
  }

  void setEmployeeID(String employeeID) {
    _employeeID = employeeID;
  }

  void setDateAdded(DateTime date) {
    _dateAdded = date;
  }
}
