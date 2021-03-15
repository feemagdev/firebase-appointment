import 'package:appointment/Models/business_appointment_model.dart';
import 'package:appointment/Models/business_client_model.dart';
import 'package:appointment/Models/company_model.dart';
import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Models/personal_appointment_model.dart';
import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/Screens/add_business_appointment_screen.dart';
import 'package:appointment/Screens/add_business_client_screen.dart';
import 'package:appointment/Screens/update_business_appointment_screen.dart';
import 'package:appointment/Screens/update_business_client_screen.dart';
import 'package:appointment/Screens/update_employee_screen.dart';
import 'package:appointment/Screens/update_personal_client_screen.dart';
import 'package:appointment/Screens/view_business_appointment_screen.dart';
import 'package:appointment/Screens/view_business_client_screen.dart';
import 'package:appointment/screens/add_employee_screen.dart';
import 'package:appointment/screens/add_personal_appointment_screen.dart';
import 'package:appointment/screens/add_personal_client_screen.dart';
import 'package:appointment/screens/dashboard_screen.dart';
import 'package:appointment/screens/update_personal_appointment_screen.dart';
import 'package:appointment/screens/veiw_personal_client_screen.dart';
import 'package:appointment/screens/view_company_screen.dart';
import 'package:appointment/screens/view_employee_screen.dart';
import 'package:appointment/screens/view_personal_appointment_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case DashboardScreen.routeName:
        return MaterialPageRoute(builder: (_) => DashboardScreen());
      case AddEmployeeScreen.routeName:
        return MaterialPageRoute(builder: (_) => AddEmployeeScreen());
      case AddPersonalAppointmentScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => AddPersonalAppointmentScreen());
      case AddPersonalClientScreen.routeName:
        return MaterialPageRoute(builder: (_) => AddPersonalClientScreen());
      case ViewPersonalAppointmentScreen.routeName:
        List<Employee> employees = args;
        return MaterialPageRoute(
            builder: (_) =>
                ViewPersonalAppointmentScreen(employees: employees));
      case ViewPersonalClientScreen.routeName:
        return MaterialPageRoute(builder: (_) => ViewPersonalClientScreen());
      case ViewEmployeeScreen.routeName:
        return MaterialPageRoute(builder: (_) => ViewEmployeeScreen());
      case UpdatePersonalAppointmentScreen.routeName:
        List list = args;
        Employee oldEmployee = list[0];
        PersonalAppointment oldAppointment = list[1];
        PersonalClient oldClient = list[2];
        return MaterialPageRoute(
            builder: (_) => UpdatePersonalAppointmentScreen(
                  oldAppointment: oldAppointment,
                  oldClient: oldClient,
                  oldEmployee: oldEmployee,
                ));
      case UpdatePersonalClientScreen.routeName:
        PersonalClient client = args;
        return MaterialPageRoute(
            builder: (_) => UpdatePersonalClientScreen(client: client));
      case UpdateEmployeeScreen.routeName:
        Employee employee = args;
        return MaterialPageRoute(
            builder: (_) => UpdateEmployeeScreen(employee: employee));
      case ViewBusinessClientScreen.routeName:
        return MaterialPageRoute(builder: (_) => ViewBusinessClientScreen());
      case AddBusinessClientScreen.routeName:
        return MaterialPageRoute(builder: (_) => AddBusinessClientScreen());
      case UpdateBusinessClientScreen.routeName:
        BusinessClient bClient = args;
        return MaterialPageRoute(
            builder: (_) => UpdateBusinessClientScreen(bClient: bClient));
      case ViewBusinessAppointmentScreen.routeName:
        List<Employee> employees = args;
        return MaterialPageRoute(
            builder: (_) => ViewBusinessAppointmentScreen(
                  employees: employees,
                ));
      case AddBusinessAppointmentScreen.routeName:
        return MaterialPageRoute(
            builder: (_) => AddBusinessAppointmentScreen());
      case UpdateBusinessAppointmentScreen.routeName:
        List list = args;
        Employee oldEmployee = list[0];
        BusinessAppointment oldBAppointment = list[1];
        BusinessClient oldBClient = list[2];
        return MaterialPageRoute(
            builder: (_) => UpdateBusinessAppointmentScreen(
                  oldBAppointment: oldBAppointment,
                  oldBClient: oldBClient,
                  oldEmployee: oldEmployee,
                ));
      case CompanyScreen.routeName:
        Company company = args;
        return MaterialPageRoute(
            builder: (_) => CompanyScreen(
                  company: company,
                ));
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
