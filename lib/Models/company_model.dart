import 'package:meta/meta.dart';

class Company {
  final String id;
  final String phone;
  final String company;
  final String address;
  final String city;
  final String state;
  final String zipcode;
  final String aptConfirmMsg;
  final String aptCancelMsg;
  final String employeeCancelMsg;
  final String aptReminderMsg;

  Company(
      {this.id,
      @required this.phone,
      @required this.company,
      @required this.address,
      @required this.city,
      @required this.state,
      @required this.zipcode,
      @required this.aptConfirmMsg,
      @required this.aptCancelMsg,
      @required this.employeeCancelMsg,
      @required this.aptReminderMsg});

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'company': company,
      'address': address,
      'city': city,
      'state': state,
      'zipcode': zipcode,
      'appointment_confirm_message': aptConfirmMsg,
      'appointment_cancel_message': aptCancelMsg,
      'employee_cancel_msg': employeeCancelMsg,
      'appointment_reminder_msg': aptReminderMsg
    };
  }

  Company.fromMap(Map snapshot, String id)
      : id = id,
        phone = snapshot['phone'],
        company = snapshot['company'],
        address = snapshot['address'],
        city = snapshot['city'],
        state = snapshot['state'],
        zipcode = snapshot['zipcode'],
        aptConfirmMsg = snapshot['appointment_confirm_message'],
        aptCancelMsg = snapshot['appointment_cancel_message'],
        employeeCancelMsg = snapshot['employee_cancel_msg'],
        aptReminderMsg = snapshot['appointment_reminder_msg'];

  String getID() {
    return id;
  }

  String getPhone() {
    return phone;
  }

  String getCompany() {
    return company;
  }

  String getAddress() {
    return address;
  }

  String getCity() {
    return city;
  }

  String getState() {
    return state;
  }

  String getZipcode() {
    return zipcode;
  }

  String getAptConfirmMsg() {
    return aptConfirmMsg;
  }

  String getAptCancelMsg() {
    return aptCancelMsg;
  }

  String getEmployeeCancelMsg() {
    return employeeCancelMsg;
  }

  String getAptReminderMsg() {
    return aptReminderMsg;
  }
}

/*

  void setPhone(String phone) {
    _phone = phone;
  }

  void setCompany(String company) {
    _company = company;
  }

  void setAddress(String address) {
    _address = address;
  }

  void setCity(String city) {
    _city = city;
  }

  void setCompanyState(String state) {
    _state = state;
  }

  void setZipcode(String zipcode) {
    _zipcode = zipcode;
  }

  void setAptConfirmMsg(String aptConfirmMsg) {
    _aptConfirmMsg = aptConfirmMsg;
  }

  void setAptCancelMsg(String aptCancelMsg) {
    _aptCancelMsg = aptCancelMsg;
  }

  void setEmployeeCancelMsg(String employeeCancelMsg) {
    _employeeCancelMsg = employeeCancelMsg;
  }

  void setReminderMsg(String aptReminderMsg) {
    _aptReminderMsg = aptReminderMsg;
  }
} */