import 'package:flutter/material.dart';
import 'package:rate_it/screens/credits_page.dart';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:rate_it/screens/profile_page.dart';
import 'package:rate_it/widgets/search_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_it/screens/home_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);



  @override
  _MyHomePageState createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  final List<Widget> _pages = [    HomePage(),    CreditsPage(), ProfilePage()];

  void _onItemTapped(int index) {
    DatabaseReference _testRef = FirebaseDatabase.instance.reference().child("test");
    _testRef.set("Hello world ${Random().nextInt(100)}");

    setState(() {
      _selectedIndex = index;
    });
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
                backgroundImage: AssetImage("assets/user_icon.png"),
                radius: 60,
              ),
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              onDetailsPressed: (){
                _onItemTapped(2);
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
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Visibility(
            visible: _selectedIndex == 0,
            child: RoundedSearchBar(hintText: "Search...", icon: const Icon(FontAwesomeIcons.search))
        ),
        actions: [
          IconButton(
              onPressed: (){
                _onItemTapped(2);
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