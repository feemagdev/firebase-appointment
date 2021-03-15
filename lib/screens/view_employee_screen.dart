import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Screens/update_employee_screen.dart';
import 'package:appointment/bloc/view_employee_bloc/view_employee_bloc.dart';
import 'package:appointment/screens/add_employee_screen.dart';
import 'package:appointment/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewEmployeeScreen extends StatelessWidget {
  static const String routeName = 'view_employee_screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewEmployeeBloc(),
      child: VeiwEmployeeBody(),
    );
  }
}

class VeiwEmployeeBody extends StatefulWidget {
  @override
  _VeiwEmployeeBodyState createState() => _VeiwEmployeeBodyState();
}

class _VeiwEmployeeBodyState extends State<VeiwEmployeeBody> {
  List<Employee> _employees;
  Employee _selectedEmployee;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[700],
        onPressed: () {
          navigateToAddEmployeeScreen(context);
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Employees"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigateToDashboardScreen(context);
          },
        ),
      ),
      body: Stack(
        children: [
          BlocListener<ViewEmployeeBloc, ViewEmployeeState>(
            listener: (context, state) {},
            child: BlocBuilder<ViewEmployeeBloc, ViewEmployeeState>(
              builder: (context, state) {
                if (state is ViewEmployeeInitial) {
                  BlocProvider.of<ViewEmployeeBloc>(context)
                      .add(GetEmployeesListEvent());
                  return Container();
                } else if (state is GetEmployeesListState) {
                  _employees = state.employeesList;
                  return listOfEmployees();
                } else if (state is ViewEmployeeLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget listOfEmployees() {
    return SingleChildScrollView(
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        shrinkWrap: true,
        itemCount: _employees.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              _selectedEmployee = _employees[index];
              navigateToUpdateEmployeeScreen(context);
            },
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _employees[index].getEmployeeName(),
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      _employees[index].getEmployeePhone(),
                      textScaleFactor: 1.1,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void navigateToDashboardScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
  }

  void navigateToAddEmployeeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, AddEmployeeScreen.routeName);
  }

  void navigateToUpdateEmployeeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, UpdateEmployeeScreen.routeName,
        arguments: _selectedEmployee);
  }
}
