import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Models/personal_appointment_model.dart';
import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/bloc/update_personal_appointment_bloc/update_personal_appointment_bloc.dart';
import 'package:appointment/screens/view_personal_appointment_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UpdatePersonalAppointmentScreen extends StatelessWidget {
  static const String routeName = 'update_personal_appointment_screen';
  final PersonalClient oldClient;
  final PersonalAppointment oldAppointment;
  final Employee oldEmployee;
  UpdatePersonalAppointmentScreen(
      {@required this.oldClient,
      @required this.oldAppointment,
      @required this.oldEmployee});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePersonalAppointmentBloc(
          oldClient: oldClient,
          oldAppointment: oldAppointment,
          oldEmployee: oldEmployee),
      child: UpdatePersonalAppointmentBody(),
    );
  }
}

class UpdatePersonalAppointmentBody extends StatefulWidget {
  @override
  _UpdatePersonalAppointmentBodyState createState() =>
      _UpdatePersonalAppointmentBodyState();
}

class _UpdatePersonalAppointmentBodyState
    extends State<UpdatePersonalAppointmentBody> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  List<Employee> _employees = [];
  List<PersonalClient> _clients = [];
  PersonalAppointment _oldAppointment;
  Employee _selectedEmployee;
  PersonalClient _selectedClient;
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  bool _confirmed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Personal Client",
          textScaleFactor: 1,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            navigateToViewPersonalAppointmentScreen(context);
          },
        ),
      ),
      body: Stack(
        children: [
          BlocListener<UpdatePersonalAppointmentBloc,
              UpdatePersonalAppointmentState>(
            listener: (context, state) {
              if (state is PersonalAppointmentUpdatedSuccessfullyState) {
                return successDialogAlert("Appointment Added Successfully");
              }
            },
            child: BlocBuilder<UpdatePersonalAppointmentBloc,
                UpdatePersonalAppointmentState>(builder: (context, state) {
              if (state is UpdatePersonalAppointmentInitial) {
                BlocProvider.of<UpdatePersonalAppointmentBloc>(context)
                    .add(GetEmployeeAndClientDataEvent());
                return Container();
              } else if (state is UpdatePersonalAppointmentLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetEmployeeAndClientDataState) {
                _employees = state.employees;
                _clients = state.clients;
                _selectedEmployee =
                    BlocProvider.of<UpdatePersonalAppointmentBloc>(context)
                        .oldEmployee;
                _selectedClient =
                    BlocProvider.of<UpdatePersonalAppointmentBloc>(context)
                        .oldClient;
                _oldAppointment =
                    BlocProvider.of<UpdatePersonalAppointmentBloc>(context)
                        .oldAppointment;
                _selectedDate = _oldAppointment.getAppointmentDate();
                _selectedTime = TimeOfDay(
                    hour: _oldAppointment.getAppointmentTime().hour,
                    minute: _oldAppointment.getAppointmentTime().minute);
                _dateController.text =
                    DateFormat.yMMMMd('en_US').format(_selectedDate);
                _timeController.text = _selectedTime.format(context);
                _confirmed = _oldAppointment.getStatus();
                return _personalClientAppointmentFormUI();
              }
              return Container();
            }),
          )
        ],
      ),
    );
  }

  Widget _personalClientAppointmentFormUI() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
              _oldAppointment.setEmployeeID(_selectedEmployee.getEmployeeID());
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          DropdownSearch<PersonalClient>(
            showSearchBox: true,
            dropdownSearchDecoration: InputDecoration(
                hintText: "Search by name or phone",
                contentPadding: EdgeInsets.all(0.0)),
            searchBoxDecoration:
                InputDecoration(hintText: "Search by name or phone"),
            items: _clients,
            selectedItem: _selectedClient,
            itemAsString: (PersonalClient u) =>
                u.getPhone() + ", " + u.getLastName() + ", " + u.getFirstName(),
            onChanged: (PersonalClient data) {
              _selectedClient = data;
              _oldAppointment.setClientID(_selectedClient.getClientID());
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          TextField(
            controller: _dateController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: "select date",
            ),
            onTap: () async {
              _selectedDate = await showDatePicker(
                  context: context,
                  initialDate:
                      _selectedDate == null ? DateTime.now() : _selectedDate,
                  firstDate: DateTime(2015),
                  lastDate: DateTime(DateTime.now().year + 10));

              setState(() {
                if (_selectedDate == null) {
                  _selectedDate = DateTime.now();
                  _dateController.text =
                      DateFormat.yMMMMd('en_US').format(_selectedDate);
                } else {
                  _dateController.text =
                      DateFormat.yMMMMd('en_US').format(_selectedDate);
                  _oldAppointment.setAppointmentDate(_selectedDate);
                }
              });
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          TextField(
              controller: _timeController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: "select time",
              ),
              onTap: () async {
                _selectedTime = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime == null
                        ? TimeOfDay.now()
                        : _selectedTime);

                setState(() {
                  if (_selectedTime == null) {
                    _selectedTime = TimeOfDay.now();
                    _timeController.text = _selectedTime.format(context);
                  } else {
                    _timeController.text = _selectedTime.format(context);
                    _oldAppointment.setAppointmentTime(DateTime(2020, 1, 1,
                        _selectedTime.hour, _selectedTime.minute, 0, 0, 0));
                  }
                });
              }),
          CheckboxListTile(
              title: Text("Confirmed ? "),
              value: _confirmed == null ? false : _confirmed,
              subtitle: Text("Checked for yes"),
              onChanged: (value) {
                setState(() {
                  _confirmed = value;
                  _oldAppointment.setStatus(_confirmed);
                });
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
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
              _oldAppointment.setDateAdded(DateTime.now());
              BlocProvider.of<UpdatePersonalAppointmentBloc>(context).add(
                  UpdatePersonalAppointmentButtonEvent(
                      oldAppointment: _oldAppointment));
            },
            child: Text(
              "Update Appointment",
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
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
            navigateToViewPersonalAppointmentScreen(context);
          },
          width: 120,
        )
      ],
    ).show().then((value) {
      navigateToViewPersonalAppointmentScreen(context);
    });
  }

  void navigateToViewPersonalAppointmentScreen(BuildContext context) {
    Navigator.pushReplacementNamed(
        context, ViewPersonalAppointmentScreen.routeName,
        arguments: _employees);
  }
}
