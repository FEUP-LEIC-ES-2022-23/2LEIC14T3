import 'package:flutter/material.dart';
import 'package:rate_it/screens/credits_page.dart';
import 'package:rate_it/screens/rating_page.dart';
import 'package:rate_it/model/review.dart';
import 'package:rate_it/screens/reviews_page.dart';
import 'package:rate_it/model/company.dart';
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';

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
      appBar: AppBar(
        title: Text('Rate IT'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Credits',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  late Future<List<Company>> futureCompanies = fetchCompanies(query: 'lol', limit: 10);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future:futureCompanies,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Company> companies = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text('Loading...');
          }
        },
      )
    );
  }
}