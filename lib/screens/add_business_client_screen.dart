import 'package:appointment/Screens/view_business_client_screen.dart';
import 'package:appointment/bloc/add_business_client_bloc/add_business_client_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBusinessClientScreen extends StatelessWidget {
  static const String routeName = 'add_business_client_screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddBusinessClientBloc(),
      child: AddBusinessClientBody(),
    );
  }
}

class AddBusinessClientBody extends StatefulWidget {
  @override
  _AddBusinessClientBodyState createState() => _AddBusinessClientBodyState();
}

class _AddBusinessClientBodyState extends State<AddBusinessClientBody> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _zipCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Client Form"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigateToViewPersonalClientScreen(context);
          },
        ),
      ),
      body: Stack(
        children: [
          BlocListener<AddBusinessClientBloc, AddBusinessClientState>(
            listener: (context, state) {
              if (state is BusinessClientAddedSuccessfullyState) {
                navigateToViewPersonalClientScreen(context);
              }
            },
            child: BlocBuilder<AddBusinessClientBloc, AddBusinessClientState>(
                builder: (context, state) {
              if (state is AddBusinessClientInitial) {
                return _bClientForm();
              } else if (state is AddBusinessClientLoadingState) {
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

  Widget _bClientForm() {
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
                  controller: _companyController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(hintText: "Company"),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "please enter company";
                    } else if (value.length <= 2) {
                      return "company name should be greater than 2";
                    } else {
                      return null;
                    }
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
                      return "contact name should be greater than 2";
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
                ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith((states) =>
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blue[700]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Add Business Client",
                        textScaleFactor: 1.2,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        BlocProvider.of<AddBusinessClientBloc>(context).add(
                            AddBusinessClientButtonEvent(
                                phone: _phoneController.text,
                                contact: _contactController.text,
                                company: _companyController.text,
                                address: _addressController.text,
                                city: _cityController.text,
                                state: _stateController.text,
                                zipCode: _zipCodeController.text));
                      }
                    })
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
    Navigator.pushReplacementNamed(context, ViewBusinessClientScreen.routeName);
  }
}
