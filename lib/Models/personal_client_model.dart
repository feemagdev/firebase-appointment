class PersonalClient {
  String _clientID;
  String _phone;
  String _lastName;
  String _firstName;
  String _address;
  String _city;
  String _state;
  String _zipCode;

  PersonalClient.fromMap(Map snapshot, String clientID)
      : _clientID = clientID,
        _phone = snapshot['phone'],
        _lastName = snapshot['last_name'],
        _firstName = snapshot['first_name'],
        _address = snapshot['address'],
        _city = snapshot['city'],
        _state = snapshot['state'],
        _zipCode = snapshot['zip_code'];

  String getClientID() {
    return _clientID;
  }

  String getPhone() {
    return _phone;
  }

  String getLastName() {
    return _lastName;
  }

  String getFirstName() {
    return _firstName;
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

  void setLastName(String lastName) {
    _lastName = lastName;
  }

  void setFirstName(String firstName) {
    _firstName = firstName;
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
