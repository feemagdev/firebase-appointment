import 'package:appointment/Models/business_client_model.dart';

import 'package:appointment/Screens/view_business_client_screen.dart';
import 'package:appointment/bloc/update_business_client_bloc/update_business_client_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateBusinessClientScreen extends StatelessWidget {
  static const String routeName = 'update_business_client_screen';
  final BusinessClient bClient;
  UpdateBusinessClientScreen({@required this.bClient});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateBusinessClientBloc(bClient: bClient),
      child: UpdateBusinessClientBody(),
    );
  }
}

class UpdateBusinessClientBody extends StatefulWidget {
  @override
  _UpdateBusinessClientBodyState createState() =>
      _UpdateBusinessClientBodyState();
}

class _UpdateBusinessClientBodyState extends State<UpdateBusinessClientBody> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  BusinessClient _bClient;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Client Form"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _navigateToViewBusinessClientScreen(context);
          },
        ),
      ),
      body: Stack(
        children: [
          BlocListener<UpdateBusinessClientBloc, UpdateBusinessClientState>(
            listener: (context, state) {
              if (state is BusinessClientUpdatedSuccessfullyState) {
                _navigateToViewBusinessClientScreen(context);
              }
            },
            child: BlocBuilder<UpdateBusinessClientBloc,
                UpdateBusinessClientState>(builder: (context, state) {
              if (state is UpdateBusinessClientInitial) {
                _bClient =
                    BlocProvider.of<UpdateBusinessClientBloc>(context).bClient;
                _phoneController.text = _bClient.getPhone();
                _companyController.text = _bClient.getCompany();
                _contactController.text = _bClient.getContact();
                _addressController.text = _bClient.getAddress();
                _zipCodeController.text = _bClient.getZipCode();
                _cityController.text = _bClient.getCity();
                _stateController.text = _bClient.getState();
                return _clientForm();
              } else if (state is UpdateBusinessClientLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container();
            }),
          )
        ],
      ),
    );
  }

  Widget _clientForm() {
    return SingleChildScrollView(
      child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(hintText: "Phone Number"),
                  validator: (value) {
                    bool phoneValidation = phoneValidator(value);
                    if (phoneValidation) {
                      return null;
                    } else {
                      return "please write a correct phone number";
                    }
                  },
                  onChanged: (value) {
                    _bClient.setPhone(value);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  controller: _companyController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(hintText: "Company"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "please enter Company";
                    } else if (value.length <= 2) {
                      return "Company name should be greater than 2";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _bClient.setCompany(value);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  controller: _contactController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(hintText: "Contact"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "please enter Contact";
                    } else if (value.length <= 2) {
                      return "Contact name should be greater than 2";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _bClient.setContact(value);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  controller: _addressController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(hintText: "Address"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "please enter address";
                    } else if (value.length <= 3) {
                      return "address should be greater than 3 characters";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _bClient.setAddress(value);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  controller: _cityController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: "City"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "please enter city name";
                    } else if (value.length <= 1) {
                      return "city name should be greater than 1";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _bClient.setCity(value);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  controller: _stateController,
                  keyboardType: TextInputType.text,
                  maxLength: 2,
                  decoration: InputDecoration(
                    hintText: "State",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "please enter state";
                    } else if (value.length <= 1) {
                      return "stae name should be 2 characters";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _bClient.setState(value);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  controller: _zipCodeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Zip Code"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "please enter zip code";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _bClient.setZipCode(value);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: ElevatedButton(
                      child: Text(
                        "Update Client",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          BlocProvider.of<UpdateBusinessClientBloc>(context)
                              .add(UpdateBusinessClientButtonEvent(
                                  bClient: _bClient));
                        }
                      }),
                )
              ],
            ),
          )),
    );
  }

  bool phoneValidator(String phone) {
    String pattern = r"^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$";
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(phone)) {
      return true;
    }
    return false;
  }

  void _navigateToViewBusinessClientScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, ViewBusinessClientScreen.routeName);
  }
}
