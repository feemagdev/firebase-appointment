import 'package:appointment/Models/business_client_model.dart';
import 'package:appointment/Screens/add_business_client_screen.dart';
import 'package:appointment/Screens/dashboard_screen.dart';
import 'package:appointment/Screens/update_business_client_screen.dart';
import 'package:appointment/bloc/view_business_client_bloc/view_business_client_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ViewBusinessClientScreen extends StatelessWidget {
  static const String routeName = 'veiw_business_client_screen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewBusinessClientBloc(),
      child: ViewBusinessClientBody(),
    );
  }
}

class ViewBusinessClientBody extends StatefulWidget {
  @override
  _ViewBusinessClientBodyState createState() => _ViewBusinessClientBodyState();
}

class _ViewBusinessClientBodyState extends State<ViewBusinessClientBody> {
  List<BusinessClient> _businessClientList = [];
  List<BusinessClient> _filteredBusinessClients = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Business Clients",
          textScaleFactor: 1,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            _nvigateToDashboard(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[700],
        child: Icon(Icons.add),
        onPressed: () {
          _nvaigateToAddBusinessClientScreen(context);
        },
      ),
      body: Stack(
        children: [
          BlocListener<ViewBusinessClientBloc, ViewBusinessClientState>(
            listener: (context, state) {
              if (state is BusinessClientSelectedState) {
                _navigateToCBusinesslientDetailScreen(context, state.bClient);
              }
            },
            child: BlocBuilder<ViewBusinessClientBloc, ViewBusinessClientState>(
              builder: (context, state) {
                if (state is ViewBusinessClientInitial) {
                  BlocProvider.of<ViewBusinessClientBloc>(context)
                      .add(GetBusinessClientListEvent());
                  return Container();
                } else if (state is BusinessClientSearchingState) {
                  _businessClientList = state.bClientList;
                  _filteredBusinessClients = state.filteredList;
                  return _selectBusinessClientUI();
                } else if (state is GetBusinessClientListState) {
                  _businessClientList = state.bClientList;
                  _filteredBusinessClients = state.bClientList;
                  return _selectBusinessClientUI();
                } else if (state is ViewBusinessClientLoadingState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NoBusinessClientFoundState) {
                  return Center(
                      child: Text("Sorry You have no business clients"));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectBusinessClientUI() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          _searchBarUI(),
          _listOfClients(),
        ],
      ),
    );
  }

  Widget _searchBarUI() {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        hintText: 'Filter by company or phone',
      ),
      onChanged: (string) {
        BlocProvider.of<ViewBusinessClientBloc>(context).add(
            BClientSearchingEvent(
                bClientList: _businessClientList, query: string));
      },
    );
  }

  Widget _listOfClients() {
    return Expanded(
      child: SingleChildScrollView(
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          shrinkWrap: true,
          itemCount: _filteredBusinessClients.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                BlocProvider.of<ViewBusinessClientBloc>(context).add(
                    ViewSelectedBusinessClientEvent(
                        bClient: _filteredBusinessClients[index]));
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _filteredBusinessClients[index].getCompany() +
                            ", " +
                            _filteredBusinessClients[index].getContact(),
                        textScaleFactor: 1.2,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        _filteredBusinessClients[index]
                            .getPhone()
                            .toLowerCase(),
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

  void _nvaigateToAddBusinessClientScreen(BuildContext context) {
    Navigator.pushReplacementNamed(context, AddBusinessClientScreen.routeName);
  }

  void _navigateToCBusinesslientDetailScreen(
      BuildContext context, BusinessClient bClient) {
    Navigator.pushReplacementNamed(
        context, UpdateBusinessClientScreen.routeName,
        arguments: bClient);
  }

  void _nvigateToDashboard(BuildContext context) {
    Navigator.pushReplacementNamed(context, DashboardScreen.routeName);
  }
}
