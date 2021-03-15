import 'package:appointment/Models/business_appointment_model.dart';
import 'package:appointment/Models/business_client_model.dart';
import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/Screens/view_business_appointment_screen.dart';
import 'package:appointment/bloc/update_business_appointment_bloc/update_business_appointment_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UpdateBusinessAppointmentScreen extends StatelessWidget {
  static const String routeName = 'update_business_appointment_screen';
  final BusinessClient oldBClient;
  final BusinessAppointment oldBAppointment;
  final Employee oldEmployee;
  UpdateBusinessAppointmentScreen(
      {@required this.oldBClient,
      @required this.oldBAppointment,
      @required this.oldEmployee});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateBusinessAppointmentBloc(
          oldBClient: oldBClient,
          oldBAppointment: oldBAppointment,
          oldEmployee: oldEmployee),
      child: UpdateBusinessAppointmentBody(),
    );
  }
}

class UpdateBusinessAppointmentBody extends StatefulWidget {
  @override
  _UpdateBusinessAppointmentBodyState createState() =>
      _UpdateBusinessAppointmentBodyState();
}

class _UpdateBusinessAppointmentBodyState
    extends State<UpdateBusinessAppointmentBody> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  List<Employee> _employees = [];
  List<BusinessClient> _bClients = [];
  BusinessAppointment _oldBAppointment;
  Employee _selectedEmployee;
  BusinessClient _selectedBClient;
  DateTime _selectedDate;
  TimeOfDay _selectedTime;
  bool _confirmed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Business Appointment Form"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _navigateToViewBusinessAppointmentScreen(context);
          },
        ),
      ),
      body: Stack(
        children: [
          BlocListener<UpdateBusinessAppointmentBloc,
              UpdateBusinessAppointmentState>(
            listener: (context, state) {
              if (state is BusinessAppointmentUpdatedSuccessfullyState) {
                return successDialogAlert("Appointment Updated Successfully");
              }
            },
            child: BlocBuilder<UpdateBusinessAppointmentBloc,
                UpdateBusinessAppointmentState>(builder: (context, state) {
              if (state is UpdateBusinessAppointmentInitial) {
                BlocProvider.of<UpdateBusinessAppointmentBloc>(context)
                    .add(GetEmployeeAndClientDataEvent());
                return Container();
              } else if (state is UpdateBusinessAppointmentLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetEmployeeAndClientDataState) {
                _employees = state.employees;
                _bClients = state.bClients;
                _selectedEmployee =
                    BlocProvider.of<UpdateBusinessAppointmentBloc>(context)
                        .oldEmployee;
                _selectedBClient =
                    BlocProvider.of<UpdateBusinessAppointmentBloc>(context)
                        .oldBClient;
                _oldBAppointment =
                    BlocProvider.of<UpdateBusinessAppointmentBloc>(context)
                        .oldBAppointment;
                _selectedDate = _oldBAppointment.getAppointmentDate();
                _selectedTime = TimeOfDay(
                    hour: _oldBAppointment.getAppointmentTime().hour,
                    minute: _oldBAppointment.getAppointmentTime().minute);
                _dateController.text =
                    DateFormat.yMMMMd('en_US').format(_selectedDate);
                _timeController.text = _selectedTime.format(context);
                _confirmed = _oldBAppointment.getStatus();
                return _businessClientAppointmentFormUI();
              }
              return Container();
            }),
          )
        ],
      ),
    );
  }

  Widget _businessClientAppointmentFormUI() {
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
              _oldBAppointment.setEmployeeID(_selectedEmployee.getEmployeeID());
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          DropdownSearch<BusinessClient>(
            showSearchBox: true,
            dropdownSearchDecoration: InputDecoration(
                hintText: "Search by name or phone",
                contentPadding: EdgeInsets.all(0.0)),
            searchBoxDecoration:
                InputDecoration(hintText: "Search by company or phone"),
            items: _bClients,
            selectedItem: _selectedBClient,
            itemAsString: (BusinessClient u) =>
                u.getPhone() + ", " + u.getCompany() + ", " + u.getContact(),
            onChanged: (BusinessClient data) {
              _selectedBClient = data;
              _oldBAppointment.setBClientID(_selectedBClient.getBClientID());
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
                  _oldBAppointment.setAppointmentDate(_selectedDate);
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
                    _oldBAppointment.setAppointmentTime(DateTime(2020, 1, 1,
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
                  _oldBAppointment.setStatus(_confirmed);
                });
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          ElevatedButton(
            onPressed: () {
              _oldBAppointment.setDateAdded(DateTime.now());
              BlocProvider.of<UpdateBusinessAppointmentBloc>(context).add(
                  UpdateBusinessAppointmentButtonEvent(
                      oldBAppointment: _oldBAppointment));
            },
            child: Text("Update Appointment"),
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
            _navigateToViewBusinessAppointmentScreen(context);
          },
          width: 120,
        )
      ],
    ).show().then((value) {
      _navigateToViewBusinessAppointmentScreen(context);
    });
  }

  void _navigateToViewBusinessAppointmentScreen(BuildContext context) {
    Navigator.pushReplacementNamed(
        context, ViewBusinessAppointmentScreen.routeName,
        arguments: _employees);
  }
}
