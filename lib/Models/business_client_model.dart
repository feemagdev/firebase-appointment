class BusinessClient {
  String _bClientID;
  String _phone;
  String _company;
  String _contact;
  String _address;
  String _city;
  String _state;
  String _zipCode;

  BusinessClient.fromMap(Map snapshot, String bClientID)
      : _bClientID = bClientID,
        _phone = snapshot['phone'],
        _company = snapshot['company'],
        _contact = snapshot['contact'],
        _address = snapshot['address'],
        _city = snapshot['city'],
        _state = snapshot['state'],
        _zipCode = snapshot['zip_code'];

  String getBClientID() {
    return _bClientID;
  }

  String getPhone() {
    return _phone;
  }

  String getCompany() {
    return _company;
  }

  String getContact() {
    return _contact;
  }

  String getAddress() {
    return _address;
  }

  String getCity() {
    return _city;
  }

  String getState() {
    return _state;
  }

  String getZipCode() {
    return _zipCode;
  }

  void setPhone(String phone) {
    _phone = phone;
  }

  void setAddress(String address) {
    _address = address;
  }

  void setCompany(String company) {
    _company = company;
  }

  void setContact(String contact) {
    _contact = contact;
  }

  void setCity(String city) {
    _city = city;
  }

  void setState(String state) {
    _state = state;
  }

  void setZipCode(String zipCode) {
    _zipCode = zipCode;
  }
}
