import 'package:flutter/material.dart';
import 'package:rate_it/screens/credits_page.dart';
import 'package:rate_it/screens/rating_page.dart';
import 'package:rate_it/model/review.dart';
import 'package:rate_it/screens/reviews_page.dart';
import 'package:rate_it/model/company.dart';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:rate_it/widgets/top_tab_bar.dart';
import 'package:rate_it/widgets/search_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




import '../model/company.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);



  @override
  _MyHomePageState createState() => _MyHomePageState();
}




class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex = 0;
  final List<Widget> _pages = [    HomePage(),    CreditsPage()];

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
            const UserAccountsDrawerHeader(
                accountName: Text("oi"),
                accountEmail: Text("oi"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("assets/user_icon.png"),
                  radius: 60,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
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
        title: Row(
          children: [
            Visibility(
              visible: _selectedIndex == 0,
                child: RoundedSearchBar(hintText: "Search...", icon: const Icon(FontAwesomeIcons.search))
            ),
            ButtonTheme(
              child: ElevatedButton(
                onPressed: (){

                },
                child: Icon(FontAwesomeIcons.user, size: 20,),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Colors.grey[300],
                  onPrimary: Colors.black,

                ),
              ),
            )
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

class HomePage extends StatelessWidget {
  late Future<List<Company>> futureCompanies = fetchCompanies(query: 'lol', limit: 10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TopTabBar(),
      ),
      body: FutureBuilder(
        future:futureCompanies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Company> companies = snapshot.data!;
            return Center(
              child: ListView(
                children: [
                  for(var company in companies)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EventRatingPage(company: company)),
                            );
                          },
                          child: Text(company.name),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewsPage(company: company,),
                              ),
                            );
                          },
                          child: Text('See Reviews'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text('Loading...');
          }
        },
      ),
    );
  }
}