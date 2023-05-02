import 'package:flutter/material.dart';
import 'package:rate_it/auth/Authentication.dart';
import 'package:rate_it/screens/credits_page.dart';
import 'package:rate_it/screens/login_page.dart';
import 'package:rate_it/screens/profile_page.dart';
import 'package:rate_it/widgets/search_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_it/screens/home_page.dart';

import '../firebase/database.dart';
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
      ProfilePage(user: User(firstName: "",lastName: "",username: "",email: "")),
    ];
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
    setState(() {
      _pages[2] = ProfilePage(user: user);
    });
    _onItemTapped(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEdgeDragWidth: 50,
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("oi"),
              accountEmail: Text("oi"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/random/200x200?people'),
                radius: 60,
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              onDetailsPressed: () async {
                await _userProfile();
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.house),
              title: Text("Home"),
              onTap: (){
                _onItemTapped(0);
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.peopleGroup),
              title: Text("Credits"),
              onTap: (){
                _onItemTapped(1);
              },
            ),
            ListTile(
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
            child: RoundedSearchBar(controller: _searchController, onSubmitted: _onSearchSubmitted,),
        ),
        actions: [
          IconButton(
              onPressed: () async{
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