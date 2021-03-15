import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/bloc/update_employee_bloc/update_employee_bloc.dart';
import 'package:appointment/screens/view_employee_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateEmployeeScreen extends StatelessWidget {
  static const String routeName = 'update_employee_screen';
  final Employee employee;
  UpdateEmployeeScreen({@required this.employee});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateEmployeeBloc(employee: employee),
      child: UpdateEmployeeBody(),
    );
  }
}

class UpdateEmployeeBody extends StatefulWidget {
  @override
  _UpdateEmployeeBodyState createState() => _UpdateEmployeeBodyState();
}

class _UpdateEmployeeBodyState extends State<UpdateEmployeeBody> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  Employee _employee;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Employee Form",
          textScaleFactor: 1,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigateToViewEmployeeScreen(context);
          },
        ),
      ),
      body: Stack(
        children: [
          BlocListener<UpdateEmployeeBloc, UpdateEmployeeState>(
            listener: (context, state) {
              if (state is EmployeeUpdatedSuccessfullyState) {
                navigateToViewEmployeeScreen(context);
              }
            },
            child: BlocBuilder<UpdateEmployeeBloc, UpdateEmployeeState>(
              builder: (context, state) {
                if (state is UpdateEmployeeInitial) {
                  _employee =
                      BlocProvider.of<UpdateEmployeeBloc>(context).employee;
                  _nameController.text = _employee.getEmployeeName();
                  _phoneController.text = _employee.getEmployeePhone();
                  return _employeeFormUI();
                } else if (state is UpdateEmployeeLoadingState) {
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
              onChanged: (value) {
                _employee.setEmployeeName(value);
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
                bool phoneValidation = phoneValidator(value);
                if (phoneValidation) {
                  return null;
                } else {
                  return "please write a correct phone number";
                }
              },
              onChanged: (value) {
                _employee.setEmployeePhone(value);
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
                  BlocProvider.of<UpdateEmployeeBloc>(context)
                      .add(UpdateEmployeeButtonEvent(employee: _employee));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Update Employee",
                  textScaleFactor: 1.2,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
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

  void navigateToViewEmployeeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, ViewEmployeeScreen.routeName);
  }
}
