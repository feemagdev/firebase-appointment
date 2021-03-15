import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Models/personal_appointment_model.dart';
import 'package:appointment/bloc/view_personal_appointment_bloc/personal_appointment_bloc.dart';
import 'package:appointment/screens/add_personal_appointment_screen.dart';
import 'package:appointment/screens/dashboard_screen.dart';
import 'package:appointment/screens/update_personal_appointment_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ViewPersonalAppointmentScreen extends StatelessWidget {
  static const String routeName = 'view_personal_appointment_screen';
  final List<Employee> employees;
  ViewPersonalAppointmentScreen({@required this.employees});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PersonalAppointmentBloc(employees: employees),
      child: PersonalAppointmentBody(),
    );
  }
}

class PersonalAppointmentBody extends StatefulWidget {
  @override
  _PersonalAppointmentBodyState createState() =>
      _PersonalAppointmentBodyState();
}

class _PersonalAppointmentBodyState extends State<PersonalAppointmentBody> {
  TextEditingController _dateController = TextEditingController();
  List<Employee> _employees;
  List<PersonalAppointment> _appointments;
  List<PersonalClient> _personalClients;
  DateTime _selectedDate;
  Employee _selectedEmployee;
  PersonalAppointment _selectedAppointment;
  PersonalClient _selectedClient;
  int selectedIndex;

  @override
  Widget build(BuildContext context) {
    _employees = BlocProvider.of<PersonalAppointmentBloc>(context).employees;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Personal Appointments",
            textScaleFactor: 1.0,
          ),
          leading: IconButton(
            iconSize: 20,
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              navigateToDashboardScreen(context);
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
                          print("send confirmation message");
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
                                _selectedAppointment.getAppointmentID());
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
                            navigateToUpdatePersonalAppointmentScreen(context);
                          }
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          navigateToAddAppointmentScreen(context);
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
            BlocListener<PersonalAppointmentBloc, PersonalAppointmentState>(
              listener: (context, state) {
                if (state is PersonalAppointmentDeletedSuccessfully) {
                  successDialogAlert("Record deleted successfully");
                }
              },
              child: BlocBuilder<PersonalAppointmentBloc,
                  PersonalAppointmentState>(
                builder: (context, state) {
                  if (state is PersonalAppointmentInitial) {
                    return Container();
                  } else if (state is GetPersonalAppointmentDataState) {
                    _appointments = state.appointments;
                    _personalClients = state.clients;
                    return Container(
                      child: Expanded(child: _appointmentListViewBuilder()),
                    );
                  } else if (state is NoPersonalAppointmentBookedState) {
                    return Center(
                      child: Text("No Appointment Booked"),
                    );
                  } else if (state is PersonalAppointmentLoadingState) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _appointmentListViewBuilder() {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _appointments.length,
          itemBuilder: (context, index) {
            return _appointmentUI(
                _appointments[index], _personalClients[index], index);
          }),
    );
  }

  Widget _appointmentUI(PersonalAppointment personalAppointment,
      PersonalClient client, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedAppointment = personalAppointment;
            _selectedClient = client;
            selectedIndex = index;
          });
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: selectedIndex == index ? Colors.blue[50] : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color.fromARGB(100, 112, 112, 112)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Client : ",
                          textScaleFactor: 1.1,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          client.getLastName() +
                              "," +
                              " " +
                              client.getFirstName(),
                          textScaleFactor: 1.1,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Phone : ",
                          textScaleFactor: 1.1,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          client.getPhone(),
                          textScaleFactor: 1.1,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Confirmed : ",
                          textScaleFactor: 1.1,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          personalAppointment.getStatus() == false
                              ? "No"
                              : "Yes",
                          textScaleFactor: 1.1,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Time : ",
                          textScaleFactor: 1.11,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat.jm()
                              .format(personalAppointment.getAppointmentTime()),
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
    return Container(
      child: Padding(
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
                    BlocProvider.of<PersonalAppointmentBloc>(context).add(
                        GetPersonalAppointmentDataEvent(
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
                onChanged: (value) {
                  print(value);
                },
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
                        BlocProvider.of<PersonalAppointmentBloc>(context).add(
                            GetPersonalAppointmentDataEvent(
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
      ),
    );
  }

  void navigateToAddAppointmentScreen(BuildContext context) {
    Navigator.pushNamed(context, AddPersonalAppointmentScreen.routeName);
  }

  void navigateToDashboardScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
  }

  void navigateToUpdatePersonalAppointmentScreen(BuildContext context) {
    List list = [];
    list.add(_selectedEmployee);
    list.add(_selectedAppointment);
    list.add(_selectedClient);
    final args = list;
    Navigator.pushReplacementNamed(
        context, UpdatePersonalAppointmentScreen.routeName,
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
      BlocProvider.of<PersonalAppointmentBloc>(context).add(
          GetPersonalAppointmentDataEvent(
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
            BlocProvider.of<PersonalAppointmentBloc>(context).add(
                DeletePersonalAppointmentEvent(appointmentID: appointmentID));
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
