import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/bloc/update_personal_client_bloc/update_personal_client_bloc.dart';
import 'package:appointment/screens/veiw_personal_client_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePersonalClientScreen extends StatelessWidget {
  static const String routeName = 'update_personal_client_screen';
  final PersonalClient client;
  UpdatePersonalClientScreen({@required this.client});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePersonalClientBloc(client: client),
      child: UpdatePersonalClientBody(),
    );
  }
}

class UpdatePersonalClientBody extends StatefulWidget {
  @override
  _UpdatePersonalClientBodyState createState() =>
      _UpdatePersonalClientBodyState();
}

class _UpdatePersonalClientBodyState extends State<UpdatePersonalClientBody> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  PersonalClient _client;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Client Form",
          textScaleFactor: 1,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigateToViewPersonalClientScreen(context);
          },
        ),
      ),
      body: Stack(
        children: [
          BlocListener<UpdatePersonalClientBloc, UpdatePersonalClientState>(
            listener: (context, state) {
              if (state is PersonalClientUpdatedSuccessfullyState) {
                navigateToViewPersonalClientScreen(context);
              }
            },
            child: BlocBuilder<UpdatePersonalClientBloc,
                UpdatePersonalClientState>(builder: (context, state) {
              if (state is UpdatePersonalClientInitial) {
                _client = state.client;
                _phoneController.text = _client.getPhone();
                _lastNameController.text = _client.getLastName();
                _firstNameController.text = _client.getFirstName();
                _addressController.text = _client.getAddress();
                _zipCodeController.text = _client.getZipCode();
                _cityController.text = _client.getCity();
                _stateController.text = _client.getState();
                return clientForm();
              } else if (state is UpdatePersonalClientLoadingState) {
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

  Widget clientForm() {
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
                    _client.setPhone(value);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(hintText: "Last Name"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "please enter last name";
                    } else if (value.length <= 2) {
                      return "last name should be greater than 2";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _client.setLastName(value);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                TextFormField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(hintText: "First Name"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "please enter first name";
                    } else if (value.length <= 2) {
                      return "first name should be greater than 2";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    _client.setFirstName(value);
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
                    _client.setAddress(value);
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
                    _client.setCity(value);
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
                    _client.setState(value);
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
                    _client.setZipCode(value);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.resolveWith((states) =>
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.blue[700]),
                      ),
                      child: Text(
                        "Update Client",
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          BlocProvider.of<UpdatePersonalClientBloc>(context)
                              .add(UpdatePersonalClientButtonEvent(
                                  client: _client));
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

  void navigateToViewPersonalClientScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, ViewPersonalClientScreen.routeName);
  }
}
