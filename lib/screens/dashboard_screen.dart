import 'package:appointment/Models/company_model.dart';
import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Screens/view_business_appointment_screen.dart';
import 'package:appointment/Screens/view_business_client_screen.dart';
import 'package:appointment/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:appointment/screens/veiw_personal_client_screen.dart';
import 'package:appointment/screens/view_company_screen.dart';
import 'package:appointment/screens/view_employee_screen.dart';
import 'package:appointment/screens/view_personal_appointment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = 'dashboard_screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: DashboardBody(),
    );
  }
}

class DashboardBody extends StatefulWidget {
  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          BlocListener<DashboardBloc, DashboardState>(
            listener: (context, state) {
              if (state is PersonalAppointmentScreenNavigationState) {
                navigateToPersonalAppointmentScreen(context, state.employees);
              } else if (state is BusinessAppointmentScreenNavigationState) {
                navigateToBusinessAppointmentScreen(context, state.employees);
              } else if (state is GetCompanyDetailState) {
                _navigateToCompanyScreen(context, state.company);
              }
            },
            child: BlocBuilder<DashboardBloc, DashboardState>(
              builder: (context, state) {
                if (state is DashboardInitial) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: _dashboardUI(),
                  );
                } else if (state is DashboardLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }
                return Container();
              },
            ),
          )
        ],
      )
          // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }

  Widget _dashboardUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        Text(
          "What can we do \nfor you ?",
          textScaleFactor: 2.0,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        _gridBuilder()
      ],
    );
  }

  Widget _gridBuilder() {
    return Expanded(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<DashboardBloc>(context)
                    .add(PersonalAppointmentScreenNavigationEvent());
              },
              child: Container(
                decoration: BoxDecoration(
                  //rgb(119,142,255)
                  color: Color.fromRGBO(119, 142, 255, 1),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/event-planner.svg',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      "Personal",
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Appointments",
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<DashboardBloc>(context)
                    .add(BusinessAppointmentScreenNavigationEvent());
              },
              child: Container(
                //rgb(105,205,237)
                decoration: BoxDecoration(
                  color: Color.fromRGBO(105, 205, 237, 1),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/schedule.svg',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      "Business",
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Appointments",
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                navigateToViewPersonalClientScreen(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  //rgb(228,130,236)
                  color: Color.fromRGBO(228, 130, 236, 1),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/pclient.svg',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      "Personal",
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Clients",
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                navigateToViewBusinessClientScreen(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  //rgb(225,116,56)
                  color: Color.fromRGBO(100, 145, 255, 1),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/group.svg',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      "Business",
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Clients",
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<DashboardBloc>(context)
                    .add(GetCompanyDetailEvent());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(105, 205, 237, 1),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/company.svg',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      "Company",
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                navigateToViewEmployeeScreen(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(64, 63, 76, 0.8),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/employees.svg',
                      width: 50,
                      height: 50,
                    ),
                    Text(
                      "Employees",
                      textScaleFactor: 1.2,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* Widget _maintenanceDashboardUI() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.12,
              decoration: BoxDecoration(
                  border: Border.all(
                      style: BorderStyle.solid,
                      color: Colors.blue,
                      width: 2.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {},
                    child: Text(
                      "Company",
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      navigateToViewEmployeeScreen(context);
                    },
                    child: Text("Employees",
                        style: TextStyle(color: Colors.white, fontSize: 17)),
                  )
                ],
              )),
        ],
      ),
    );
  } */

  void navigateToPersonalAppointmentScreen(
      BuildContext context, List<Employee> employees) {
    Navigator.pushReplacementNamed(
        context, ViewPersonalAppointmentScreen.routeName,
        arguments: employees);
  }

  void navigateToViewPersonalClientScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, ViewPersonalClientScreen.routeName);
  }

  void navigateToViewEmployeeScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, ViewEmployeeScreen.routeName);
  }

  void navigateToViewBusinessClientScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, ViewBusinessClientScreen.routeName);
  }

  void navigateToBusinessAppointmentScreen(
      BuildContext context, List<Employee> employees) {
    Navigator.pushReplacementNamed(
        context, ViewBusinessAppointmentScreen.routeName,
        arguments: employees);
  }

  void _navigateToCompanyScreen(BuildContext context, Company company) {
    Navigator.pushReplacementNamed(context, CompanyScreen.routeName,
        arguments: company);
  }
}
