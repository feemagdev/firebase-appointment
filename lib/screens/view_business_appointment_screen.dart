import 'package:appointment/Models/business_appointment_model.dart';
import 'package:appointment/Models/business_client_model.dart';
import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Screens/add_business_appointment_screen.dart';
import 'package:appointment/Screens/update_business_appointment_screen.dart';
import 'package:appointment/bloc/business_appointment_bloc/business_appointment_bloc.dart';
import 'package:appointment/screens/dashboard_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ViewBusinessAppointmentScreen extends StatelessWidget {
  static const String routeName = 'view_business_appointment_screen';
  final List<Employee> employees;
  ViewBusinessAppointmentScreen({@required this.employees});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BusinessAppointmentBloc(employees: employees),
      child: BusinessAppointmentBody(),
    );
  }
}

class BusinessAppointmentBody extends StatefulWidget {
  @override
  _BusinessAppointmentBodyState createState() =>
      _BusinessAppointmentBodyState();
}

class _BusinessAppointmentBodyState extends State<BusinessAppointmentBody> {
  TextEditingController _dateController = TextEditingController();
  List<Employee> _employees;
  List<BusinessAppointment> _bAppointments;
  List<BusinessClient> _bClients;
  DateTime _selectedDate;
  Employee _selectedEmployee;
  BusinessAppointment _selectedBAppointment;
  BusinessClient _selectedBClient;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    _employees = BlocProvider.of<BusinessAppointmentBloc>(context).employees;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Business Appointments",
          textScaleFactor: 1,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _navigateToDashboardScreen(context);
          },
        ),
      ),
      persistentFooterButtons: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _threeItemPopup(),
              /*Row(
                children: [
                  RaisedButton(
                    onPressed: () {
                      if (selectedIndex == null) {
                        infoDialogAlert("Please select an appointment");
                      } else {
                        print("send conformation message");
                      }
                    },
                    child: Text("Text Confirmation to Record"),
                  ),
                ],
              ),*/
              Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.delete_outlined,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        if (selectedIndex == null) {
                          infoDialogAlert("Please select an appointment");
                        } else {
                          warningDialogAlert(
                              "Are you sure to delete that record ?",
                              _selectedBAppointment.getBAppointmentID());
                        }
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.green[300],
                      ),
                      onPressed: () {
                        if (selectedIndex == null) {
                          infoDialogAlert("Please select an appointment");
                        } else {
                          _navigateToUpdateBusinessAppointmentScreen(context);
                        }
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        _navigateToAddBusinessAppointmentScreen(context);
                      }),
                ],
              ),
            ],
          ),
        )
      ],
      body: Column(
        children: [
          _viewPersonalAppointmentUI(),
          SizedBox(
            height: 10,
          ),
          BlocListener<BusinessAppointmentBloc, BusinessAppointmentState>(
            listener: (context, state) {
              if (state is BusinessAppointmentDeletedSuccessfully) {
                successDialogAlert("Record deleted successfully");
              }
            },
            child:
                BlocBuilder<BusinessAppointmentBloc, BusinessAppointmentState>(
              builder: (context, state) {
                if (state is BusinessAppointmentInitial) {
                  return Container();
                } else if (state is GetBusinessAppointmentDataState) {
                  _bAppointments = state.bAppointments;
                  _bClients = state.bClients;
                  return Expanded(child: _appointmentListViewBuilder());
                } else if (state is NoBusinessAppointmentBookedState) {
                  return Center(
                    child: Text("No Appointment Booked"),
                  );
                } else if (state is BusinessAppointmentLoadingState) {
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

  Widget _appointmentListViewBuilder() {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _bAppointments.length,
          itemBuilder: (context, index) {
            return _appointmentUI(
                _bAppointments[index], _bClients[index], index);
          }),
    );
  }

  Widget _appointmentUI(
      BusinessAppointment bAppointment, BusinessClient bClient, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
            _selectedBAppointment = bAppointment;
            _selectedBClient = bClient;
          });
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: selectedIndex == index ? Colors.blue[50] : Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Company : ",
                      textScaleFactor: 1.1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      bClient.getCompany(),
                      textScaleFactor: 1.1,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Contact : ",
                      textScaleFactor: 1.1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      bClient.getContact(),
                      textScaleFactor: 1.1,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Text(
                      "Phone : ",
                      textScaleFactor: 1.1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      bClient.getPhone(),
                      textScaleFactor: 1.1,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Confirmed : ",
                          textScaleFactor: 1.1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          bAppointment.getStatus() == false ? "No" : "Yes",
                          style: TextStyle(fontSize: 17),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Time : ",
                          textScaleFactor: 1.1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat.jm()
                              .format(bAppointment.getAppointmentTime()),
                          textScaleFactor: 1.1,
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _viewPersonalAppointmentUI() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        child: Column(
          children: [
            DropdownSearch<Employee>(
              showSearchBox: true,
              dropdownSearchDecoration: InputDecoration(
                  hintText: "Search by employee name",
                  contentPadding: EdgeInsets.all(0.0)),
              searchBoxDecoration:
                  InputDecoration(hintText: "Search by employee name"),
              items: _employees,
              selectedItem: _selectedEmployee,
              itemAsString: (Employee u) => u.getEmployeeName(),
              onChanged: (Employee data) {
                _selectedEmployee = data;
                if (_dateController.text.isNotEmpty) {
                  BlocProvider.of<BusinessAppointmentBloc>(context).add(
                      GetBusinessAppointmentDataEvent(
                          employeeID: _selectedEmployee.getEmployeeID(),
                          date: _selectedDate));
                  selectedIndex = null;
                }
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextField(
              controller: _dateController,
              onChanged: (value) {},
              onTap: () async {
                if (_selectedDate == null) {
                  _selectedDate = DateTime.now();
                }
                final DateTime picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    initialDatePickerMode: DatePickerMode.day,
                    firstDate: DateTime(2015),
                    lastDate: DateTime.now().add(Duration(days: 365)));
                if (picked != null) {
                  setState(() {
                    _selectedDate = picked;
                    _dateController.text =
                        DateFormat.yMd().format(_selectedDate);
                    if (_selectedEmployee != null) {
                      BlocProvider.of<BusinessAppointmentBloc>(context).add(
                          GetBusinessAppointmentDataEvent(
                              employeeID: _selectedEmployee.getEmployeeID(),
                              date: _selectedDate));
                      selectedIndex = null;
                    }
                  });
                }
              },
              decoration: InputDecoration(hintText: "Select Date"),
              readOnly: true,
            )
          ],
        ),
      ),
    );
  }

  void _navigateToAddBusinessAppointmentScreen(BuildContext context) {
    Navigator.pushNamed(context, AddBusinessAppointmentScreen.routeName);
  }

  void _navigateToDashboardScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
  }

  void _navigateToUpdateBusinessAppointmentScreen(BuildContext context) {
    List list = [];
    list.add(_selectedEmployee);
    list.add(_selectedBAppointment);
    list.add(_selectedBClient);
    final args = list;
    Navigator.pushReplacementNamed(
        context, UpdateBusinessAppointmentScreen.routeName,
        arguments: args);
  }

  successDialogAlert(String message) async {
    await Alert(
      context: context,
      type: AlertType.success,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          width: 120,
        )
      ],
    ).show().then((value) {
      BlocProvider.of<BusinessAppointmentBloc>(context).add(
          GetBusinessAppointmentDataEvent(
              employeeID: _selectedEmployee.getEmployeeID(),
              date: _selectedDate));
    });
  }

  warningDialogAlert(String message, String appointmentID) async {
    await Alert(
      context: context,
      type: AlertType.warning,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            BlocProvider.of<BusinessAppointmentBloc>(context).add(
                DeleteBusinessAppointmentEvent(appointmentID: appointmentID));
            selectedIndex = null;
          },
          width: 120,
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          width: 120,
        ),
      ],
    ).show().then((value) {});
  }

  infoDialogAlert(String message) async {
    await Alert(
      context: context,
      type: AlertType.info,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          width: 120,
        )
      ],
    ).show().then((value) {});
  }

  Widget _threeItemPopup() => PopupMenuButton(
      onSelected: (selectedvalue) {
        _sendSmsReminder(selectedvalue);
      },
      itemBuilder: (context) {
        return items();
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sms,
            size: 30,
            color: Colors.blue[700],
          ),
          Text(
            "Send Reminder",
            textScaleFactor: 1.2,
          ),
        ],
      ));

  List<PopupMenuEntry<Object>> items() {
    List<PopupMenuEntry<Object>> list = [];
    list.add(
      PopupMenuItem(
        child: Text(
          "Select Text Reminder",
        ),
      ),
    );
    list.add(
      PopupMenuDivider(
        height: 10,
      ),
    );
    list.add(
      PopupMenuItem(
        value: 'confirm',
        child: Center(
          child: Text(
            "Confirm",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );

    list.add(
      PopupMenuItem(
        value: 'confirm_all',
        child: Center(
          child: Text(
            "Confirm All",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );

    list.add(
      PopupMenuItem(
        value: 'remind',
        child: Center(
          child: Text(
            "Remind",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );

    list.add(
      PopupMenuItem(
        value: 'remind_all',
        child: Center(
          child: Text(
            "Remind All",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );

    list.add(
      PopupMenuItem(
        value: 'cancel',
        child: Center(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );

    list.add(
      PopupMenuItem(
        value: 'cancel_all',
        child: Center(
          child: Text(
            "Cancel All",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );

    list.add(
      PopupMenuItem(
        value: 'cancel_employee',
        child: Center(
          child: Text(
            "Cancel Employee",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
    list.add(
      PopupMenuDivider(
        height: 10,
      ),
    );

    list.add(
      PopupMenuItem(
        child: Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              Icons.arrow_downward_outlined,
              color: Colors.blue[700],
            )),
      ),
    );
    return list;
  }

  void _sendSmsReminder(selectedvalue) {
    switch (selectedvalue) {
      case 'confirm':
        print('confirm');
        break;
      case 'confirm_all':
        print('confirm_all');
        break;
      case 'remind':
        print('remind');
        break;
      case 'remind_all':
        print('remind_all');
        break;
      case 'cancel':
        print('cancel');
        break;
      case 'cancel_all':
        print('cancel_all');
        break;
      case 'cancel_employee':
        print('cancel_employee');
        break;
    }
  }
}
