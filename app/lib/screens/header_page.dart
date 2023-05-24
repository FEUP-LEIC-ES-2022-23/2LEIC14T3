import 'package:flutter/material.dart';
import 'package:rate_it/auth/Authentication.dart';
import 'package:rate_it/screens/credits_page.dart';
import 'package:rate_it/screens/login_page.dart';
import 'package:rate_it/screens/profile_page.dart';
import 'package:rate_it/widgets/search_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_it/screens/home_page.dart';

import '../firestore/database.dart';
import '../model/user.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);



  @override
  _MyHomePageState createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {

  String _companySearchResult = "";
  String _courseSearchResult = "";
  String _eventSearchResult = "";
  int _selectedIndex = 0;
  int _tabIndex = 0;
  List<Widget> _pages = [];
  late Future<User> user;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(
        companySearchResult: _companySearchResult,
        courseSearchResult: _courseSearchResult,
        eventSearchResult: _eventSearchResult,
        onTabChanged: _onTabChanged,
      ),
      CreditsPage(),
    ];
    String uid = Authentication.auth.currentUser!.uid;
    user = Database.getUser(uid);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchSubmitted(String value) { // added this function
    setState(() {
      if(_tabIndex == 0) {
        _companySearchResult = value;
      } else if(_tabIndex == 1) {
        _courseSearchResult = value;
      } else if(_tabIndex == 2) {
        _eventSearchResult = value;
      }
      _searchController.clear();
      updateListing();
    });
  }

  void updateListing() {
    setState(() {
      _pages[0] = HomePage(
        companySearchResult: _companySearchResult,
        courseSearchResult: _courseSearchResult,
        eventSearchResult: _eventSearchResult,
        onTabChanged: _onTabChanged,
      );
    });
  }

  void _onTabChanged(int index) { // added function to handle tab change
    setState(() {
      _tabIndex = index;
    });
  }

  Future<void> _userProfile() async {
    String uid = Authentication.auth.currentUser!.uid;
    User user = await Database.getUser(uid);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProfilePage(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            key: Key("MyHomePage"),
            drawerEdgeDragWidth: 50,
            drawer: Drawer(
              child: ListView(
                children: [
                  FutureBuilder(
                    future: user,
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.hasData){
                        User rendUser = snapshot.data!;
                        return UserAccountsDrawerHeader(
                          accountName: Text('@${rendUser.username}'),
                          accountEmail: Text(rendUser.email),
                          currentAccountPicture: CircleAvatar(
                            backgroundImage: NetworkImage(rendUser.photoURL),
                            radius: 60,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[400],
                          ),
                          onDetailsPressed: () async {
                            await _userProfile();
                          },
                        );
                      }
                      else if (snapshot.hasError){
                      return Text('Something went wrong!');
                      }
                      else return Center(child:CircularProgressIndicator());
                    },
                  ),
                  ListTile(
                    leading: Icon(FontAwesomeIcons.house),
                    title: Text("Home"),
                    onTap: () {
                      _onItemTapped(0);
                    },
                  ),
                  ListTile(
                    key: Key("creditsButton"),
                    leading: Icon(FontAwesomeIcons.peopleGroup),
                    title: Text("Credits"),
                    onTap: () {
                      _onItemTapped(1);
                    },
                  ),
                  ListTile(
                    key: Key("logoutButton"),
                    leading: Icon(FontAwesomeIcons.doorOpen),
                    title: Text("Log Out"),
                    onTap: () {
                      Authentication.logout();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            appBar: AppBar(
              title: Visibility(
                visible: _selectedIndex == 0,
                child: RoundedSearchBar(
                  key: Key("searchBar"),
                  controller: _searchController, onSubmitted: _onSearchSubmitted,),
              ),
              actions: [
                IconButton(
                  key: Key("profileButton"),
                  onPressed: () async {
                    await _userProfile();
                  },
                  icon: Icon(FontAwesomeIcons.user),
                  padding: EdgeInsets.only(right: 20),
                )
              ],
            ),
            body: _pages[_selectedIndex],
          );
  }
}