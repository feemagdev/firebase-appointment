import 'package:appointment/bloc/add_personal_client_bloc/add_personal_client_bloc.dart';
import 'package:appointment/screens/veiw_personal_client_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPersonalClientScreen extends StatelessWidget {
  static const String routeName = 'add_personal_client';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPersonalClientBloc(),
      child: AddPersonalClientBody(),
    );
  }
}

class AddPersonalClientBody extends StatefulWidget {
  @override
  _AddPersonalClientBodyState createState() => _AddPersonalClientBodyState();
}

class _AddPersonalClientBodyState extends State<AddPersonalClientBody> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Form"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigateToViewPersonalClientScreen(context);
          },
        ),
      ),
      body: Stack(
        children: [
          BlocListener<AddPersonalClientBloc, AddPersonalClientState>(
            listener: (context, state) {
              if (state is PersonalClientAddedSuccessfullyState) {
                navigateToViewPersonalClientScreen(context);
              }
            },
            child: BlocBuilder<AddPersonalClientBloc, AddPersonalClientState>(
                builder: (context, state) {
              if (state is AddPersonalClientInitial) {
                return clientForm();
              } else if (state is AddPersonalClientLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              print("container add perosnal client");
              return Container(
                color: Colors.white,
                height: 500,
                width: 200,
              );
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.50,
                  child: ElevatedButton(
                      child: Text(
                        "Add Client",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          BlocProvider.of<AddPersonalClientBloc>(context).add(
                              AddPersonalClientButtonEvent(
                                  phone: _phoneController.text,
                                  lastName: _lastNameController.text,
                                  firstName: _firstNameController.text,
                                  address: _addressController.text,
                                  city: _cityController.text,
                                  state: _stateController.text,
                                  zipCode: _zipCodeController.text));
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
