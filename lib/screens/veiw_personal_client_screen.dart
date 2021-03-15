import 'package:appointment/Models/personal_client_model.dart';
import 'package:appointment/Screens/update_personal_client_screen.dart';
import 'package:appointment/bloc/view_personal_client_bloc/view_personal_client_bloc.dart';
import 'package:appointment/screens/add_personal_client_screen.dart';
import 'package:appointment/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewPersonalClientScreen extends StatelessWidget {
  static const String routeName = 'view_personal_client_screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewPersonalClientBloc(),
      child: ViewPersonalClientBody(),
    );
  }
}

class ViewPersonalClientBody extends StatefulWidget {
  @override
  _ViewPersonalClientBodyState createState() => _ViewPersonalClientBodyState();
}

class _ViewPersonalClientBodyState extends State<ViewPersonalClientBody> {
  List<PersonalClient> clientList = [];
  List<PersonalClient> filteredClients = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Clients",
          textScaleFactor: 1,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            nvigateToDashboard(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[700],
        child: Icon(Icons.add),
        onPressed: () {
          nvaigateToAddPersonalClientScreen(context);
        },
      ),
      body: Stack(
        children: [
          BlocListener<ViewPersonalClientBloc, ViewPersonalClientState>(
            listener: (context, state) {
              if (state is ClientSelectedState) {
                navigateToClientDetailScreen(context, state.client);
              }
            },
            child: BlocBuilder<ViewPersonalClientBloc, ViewPersonalClientState>(
              builder: (context, state) {
                if (state is ViewPersonalClientInitial) {
                  BlocProvider.of<ViewPersonalClientBloc>(context)
                      .add(GetClientListEvent());
                  return Container();
                } else if (state is ClientSearchingState) {
                  clientList = state.clientList;
                  filteredClients = state.filteredList;
                  return selectClientUI();
                } else if (state is GetClientListState) {
                  clientList = state.clientList;
                  filteredClients = state.clientList;
                  return selectClientUI();
                } else if (state is ViewPersonalClientLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NoClientFoundState) {
                  return Center(child: Text("Sorry You have no clients"));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget selectClientUI() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          searchBarUI(),
          listOfClients(),
        ],
      ),
    );
  }

  Widget searchBarUI() {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'Filter by last name or phone',
      ),
      onChanged: (string) {
        BlocProvider.of<ViewPersonalClientBloc>(context)
            .add(ClientSearchingEvent(clientList: clientList, query: string));
      },
    );
  }

  Widget listOfClients() {
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          shrinkWrap: true,
          itemCount: filteredClients.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                BlocProvider.of<ViewPersonalClientBloc>(context).add(
                    ViewSelectedClientEvent(client: filteredClients[index]));
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        filteredClients[index].getLastName() +
                            ", " +
                            filteredClients[index].getFirstName(),
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        filteredClients[index].getPhone().toLowerCase(),
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
      ),
    );
  }

  void nvaigateToAddPersonalClientScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, AddPersonalClientScreen.routeName);
  }

  void navigateToClientDetailScreen(
      BuildContext context, PersonalClient client) {
    Navigator.pushReplacementNamed(
        context, UpdatePersonalClientScreen.routeName,
        arguments: client);
  }

  void nvigateToDashboard(BuildContext context) {
    Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
  }

  /*Widget clientsListUI(){
    return ListView.builder(itemBuilder: null)
  }*/
}
