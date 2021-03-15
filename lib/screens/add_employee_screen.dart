import 'package:appointment/bloc/add_employee_bloc/add_employee_bloc.dart';
import 'package:appointment/screens/view_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeScreen extends StatelessWidget {
  static const String routeName = 'add_employee_screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEmployeeBloc(),
      child: AddEmployeeBody(),
    );
  }
}

class AddEmployeeBody extends StatefulWidget {
  @override
  _AddEmployeeBodyState createState() => _AddEmployeeBodyState();
}

class _AddEmployeeBodyState extends State<AddEmployeeBody> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee Form"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigateToViewEmployeeScreen(context);
          },
        ),
      ),
      body: Stack(
        children: [
          BlocListener<AddEmployeeBloc, AddEmployeeState>(
            listener: (context, state) {
              if (state is EmployeeAddedSuccessfullyState) {
                navigateToViewEmployeeScreen(context);
              }
            },
            child: BlocBuilder<AddEmployeeBloc, AddEmployeeState>(
              builder: (context, state) {
                if (state is AddEmployeeInitial) {
                  return _employeeFormUI();
                } else if (state is AddEmployeeLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container();
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _employeeFormUI() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(hintText: "Name"),
              validator: (value) {
                if (value.isEmpty) {
                  return "Please write name";
                } else if (value.length <= 2) {
                  return "Name should be more than 2 charcaters";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: "Phone Number"),
              validator: (value) {
                bool phoneValidation = _phoneValidator(value);
                if (phoneValidation) {
                  return null;
                } else {
                  return "please write a correct phone number";
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.resolveWith((states) =>
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.blue[700]),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    BlocProvider.of<AddEmployeeBloc>(context).add(
                        AddEmployeeButtonEvent(
                            name: _nameController.text,
                            phone: _phoneController.text));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Add Employee",
                    textScaleFactor: 1.2,
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  bool _phoneValidator(String phone) {
    String pattern = r"^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$";
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(phone)) {
      return true;
    }
    return false;
  }

  void navigateToViewEmployeeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, ViewEmployeeScreen.routeName);
  }
}
