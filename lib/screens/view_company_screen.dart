import 'package:appointment/Models/company_model.dart';
import 'package:appointment/bloc/compamy_bloc/company_bloc.dart';
import 'package:appointment/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CompanyScreen extends StatelessWidget {
  static const String routeName = "comapny";
  final Company company;
  CompanyScreen({@required this.company});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyBloc(),
      child: CompanyBody(company: company),
    );
  }
}

class CompanyBody extends StatefulWidget {
  final Company company;
  CompanyBody({@required this.company});
  @override
  _CompanyBodyState createState() => _CompanyBodyState(company: company);
}

class _CompanyBodyState extends State<CompanyBody> {
  final _deafultAptConfirmMsg =
      r"<CLIENT_FIRST_NAME>, please reply Y to confirm you have an appointment at <APPT_TIME> on <APPT_DATE>. Thanks! <COMPANY_NAME> <COMPANY_PHONE> P.S. There is a $35 no show fee if Appointment isn`t cancelled within 24 hours of appointment time. Text N to opt out";
  final _defaultAptCancelMsg =
      r"Notice: your appointment with <CLIENT_FIRST_NAME> <CLIENT_LAST_NAME> at <APPT_TIME> today was cancelled.";
  final _defaultEmployeeCancelMsg =
      r"Notice: your appointment with <CLIENT_FIRST_NAME> <CLIENT_LAST_NAME> at <APPT_TIME> today was cancelled.";
  final _defaultReminderMsg =
      r"Reminder: you have a confirmed appt at <APPT_TIME> today with <EMPLOYEE> at <COMPANY NAME>.";
  Company company;
  _CompanyBodyState({@required this.company});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _zipcodeController = TextEditingController();
  TextEditingController _aptConfirmMsgController = TextEditingController();
  TextEditingController _aptCancelMsgController = TextEditingController();
  TextEditingController _employeeCancelMsgController = TextEditingController();
  TextEditingController _aptReminderMsgController = TextEditingController();

  @override
  void initState() {
    _initialFunction();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Company Form",
            textScaleFactor: 1,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              _navigateToDashboardScreen(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  Company newCompany = Company(
                      id: company == null ? null : company.id,
                      phone: _phoneController.text,
                      company: _companyController.text,
                      address: _addressController.text,
                      city: _cityController.text,
                      state: _stateController.text,
                      zipcode: _zipcodeController.text,
                      aptConfirmMsg: _aptConfirmMsgController.text,
                      aptCancelMsg: _aptCancelMsgController.text,
                      employeeCancelMsg: _employeeCancelMsgController.text,
                      aptReminderMsg: _aptReminderMsgController.text);
                  company = newCompany;
                  BlocProvider.of<CompanyBloc>(context)
                      .add(SaveCompanyEvent(company: newCompany));
                }
              },
            )
          ],
        ),
        body: Stack(
          children: [
            _bloc(),
          ],
        ),
      ),
    );
  }

  Widget _bloc() {
    return BlocListener<CompanyBloc, CompanyState>(
      listener: (context, state) {
        if (state is CompanySavedSuccessfullyState) {
          return successDialogAlert("Company Saved Successfully");
        }
      },
      child: BlocBuilder<CompanyBloc, CompanyState>(
        builder: (context, state) {
          if (state is CompanyInitial) {
            return _companyFrom();
          } else if (state is CompanyLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _companyFrom() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: "1112223333", labelText: "Phone number"),
                validator: (value) {
                  bool phoneValidation = phoneValidator(value);
                  if (phoneValidation) {
                    return null;
                  } else {
                    return "please write a correct phone number";
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextFormField(
                controller: _companyController,
                decoration: InputDecoration(
                  hintText: "Microsoft",
                  labelText: "Company",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter company name";
                  } else if (value.length < 2) {
                    return "Company name should be more than 2 characters";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: "Street 15 House 12",
                  labelText: "Address",
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter Address";
                  } else if (value.length < 5) {
                    return "Company name should be more than 5 characters";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cityController,
                      decoration: InputDecoration(
                        labelText: "City",
                        hintText: "NewYork",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter City";
                        } else if (value.length < 2) {
                          return "Company name should be more than 1 characters";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: TextFormField(
                      controller: _stateController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: "State",
                        hintText: "LA",
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Invalid State";
                        } else if (value.length <= 1 || value.length > 2) {
                          return "2 characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: TextFormField(
                      controller: _zipcodeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "32200", labelText: "Zip Code"),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "No ZipCode";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextFormField(
                controller: _aptConfirmMsgController,
                keyboardType: TextInputType.text,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Appointment Confirm Message",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextFormField(
                controller: _aptCancelMsgController,
                maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Appointment Cancel Message",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextFormField(
                controller: _employeeCancelMsgController,
                maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Employee Cancel Message",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextFormField(
                controller: _aptReminderMsgController,
                maxLines: 3,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Appointment Reminder Message",
                ),
              ),
            ],
          ),
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

  void _navigateToDashboardScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
  }

  void _initialFunction() {
    if (company != null) {
      _phoneController.text = company.phone;
      _companyController.text = company.company;
      _addressController.text = company.address;
      _cityController.text = company.city;
      _stateController.text = company.state;
      _zipcodeController.text = company.zipcode;
      _aptConfirmMsgController.text = company.aptConfirmMsg;
      _aptCancelMsgController.text = company.aptCancelMsg;
      _aptReminderMsgController.text = company.aptReminderMsg;
      _employeeCancelMsgController.text = company.employeeCancelMsg;
      _companyMessagesLoader();
    } else {
      _companyMessagesLoader();
    }
  }

  void _companyMessagesLoader() {
    if (company == null || company.aptConfirmMsg.isEmpty) {
      _aptConfirmMsgController.text = _deafultAptConfirmMsg;
    }
    if (company == null || company.aptCancelMsg.isEmpty) {
      _aptCancelMsgController.text = _defaultAptCancelMsg;
    }
    if (company == null || company.employeeCancelMsg.isEmpty) {
      _employeeCancelMsgController.text = _defaultEmployeeCancelMsg;
    }
    if (company == null || company.aptReminderMsg.isEmpty) {
      _aptReminderMsgController.text = _defaultReminderMsg;
    }
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
            _navigateToDashboardScreen(context);
          },
          width: 120,
        )
      ],
    ).show().then((value) {
      _navigateToDashboardScreen(context);
    });
  }
}
