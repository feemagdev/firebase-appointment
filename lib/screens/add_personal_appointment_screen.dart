import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/Models/employee_model.dart';
import 'package:appointment/bloc/add_personal_appointment_bloc/add_personal_appointment_bloc.dart';
import 'package:appointment/screens/view_personal_appointment_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddPersonalAppointmentScreen extends StatelessWidget {
  static const String routeName = 'add_personal_appointment_screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPersonalAppointmentBloc(),
      child: AddPersonalAppointmentBody(),
    );
  }
}

class AddPersonalAppointmentBody extends StatefulWidget {
  @override
  _AddPersonalAppointmentBodyState createState() =>
      _AddPersonalAppointmentBodyState();
}

class _AddPersonalAppointmentBodyState
    extends State<AddPersonalAppointmentBody> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  List<Employee> employees = [];
  List<PersonalClient> clients;
  Employee selectedEmployee;
  PersonalClient selectedClient;
  DateTime selectedDate;
  TimeOfDay selectedTime;
  bool confirmed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Appointment Form",
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
          BlocListener<AddPersonalAppointmentBloc, AddPersonalAppointmentState>(
            listener: (context, state) {
              if (state is PersonalAppointmentAddedSuccessfullyState) {
                return successDialogAlert("Appointment Added Successfully");
              } else if (state is PersonalAppointmentValidationErrorState) {
                return validationDialogAlert(state.validation);
              }
            },
            child: BlocBuilder<AddPersonalAppointmentBloc,
                AddPersonalAppointmentState>(builder: (context, state) {
              if (state is AddPersonalAppointmentInitial) {
                BlocProvider.of<AddPersonalAppointmentBloc>(context)
                    .add(GetEmployeeAndClientDataEvent());
                return Container();
              } else if (state is AddPersonalAppointmentLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is GetEmployeeAndClientDataState) {
                employees = state.employees;
                clients = state.clients;
                print(employees[0].getEmployeeName());
                return _personalClientAppointmentFormUI();
              }
              return _personalClientAppointmentFormUI();
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
                hintText: "Employee", contentPadding: EdgeInsets.all(0.0)),
            searchBoxDecoration:
                InputDecoration(hintText: "Search by employee name"),
            items: employees,
            selectedItem: selectedEmployee,
            itemAsString: (Employee u) => u.getEmployeeName(),
            onChanged: (Employee data) {
              selectedEmployee = data;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          DropdownSearch<PersonalClient>(
            showSearchBox: true,
            dropdownSearchDecoration: InputDecoration(
                hintText: "Personal Client",
                contentPadding: EdgeInsets.all(0.0)),
            searchBoxDecoration:
                InputDecoration(hintText: "Search by name or phone"),
            items: clients,
            selectedItem: selectedClient,
            itemAsString: (PersonalClient u) =>
                u.getPhone() + ", " + u.getLastName() + ", " + u.getFirstName(),
            onChanged: (PersonalClient data) {
              selectedClient = data;
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          TextField(
            controller: _dateController,
            readOnly: true,
            decoration: InputDecoration(
              hintText: "Select date",
            ),
            onTap: () async {
              selectedDate = await showDatePicker(
                  context: context,
                  initialDate:
                      selectedDate == null ? DateTime.now() : selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 10));

              setState(() {
                if (selectedDate == null) {
                  selectedDate = DateTime.now();
                  _dateController.text =
                      DateFormat.yMMMMd('en_US').format(selectedDate);
                } else {
                  _dateController.text =
                      DateFormat.yMMMMd('en_US').format(selectedDate);
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
                hintText: "Select time",
              ),
              onTap: () async {
                selectedTime = await showTimePicker(
                    context: context,
                    initialTime:
                        selectedTime == null ? TimeOfDay.now() : selectedTime);

                setState(() {
                  if (selectedTime == null) {
                    selectedTime = TimeOfDay.now();
                    _timeController.text = selectedTime.format(context);
                  } else {
                    _timeController.text = selectedTime.format(context);
                  }
                });
              }),
          CheckboxListTile(
              title: Text("Confirmed ? "),
              value: confirmed == null ? false : confirmed,
              subtitle: Text("Checked for yes"),
              onChanged: (value) {
                setState(() {
                  confirmed = value;
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
              BlocProvider.of<AddPersonalAppointmentBloc>(context).add(
                  AddPersonalAppointmentButtonEvent(
                      appointmentDate: selectedDate,
                      appointmentTime: selectedTime,
                      dateAdded: DateTime.now(),
                      employee: selectedEmployee,
                      client: selectedClient,
                      confirmed: confirmed == null ? false : confirmed));
            },
            child: Text(
              "Add Appointment",
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
      context: this.context,
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
            Navigator.pop(this.context);
            navigateToViewPersonalAppointmentScreen(context);
          },
          width: 120,
        )
      ],
    ).show().then((value) {
      Navigator.pop(this.context);
      navigateToViewPersonalAppointmentScreen(context);
    });
  }

  validationDialogAlert(String message) async {
    await Alert(
      context: this.context,
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

  void navigateToViewPersonalAppointmentScreen(BuildContext context) {
    Navigator.pushReplacementNamed(
        context, ViewPersonalAppointmentScreen.routeName,
        arguments: employees);
  }
}
