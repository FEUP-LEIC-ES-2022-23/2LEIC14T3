import 'package:flutter/material.dart';
import 'package:my_app/screens/credits_page.dart';
import 'package:my_app/screens/rating_page.dart';
import 'package:my_app/model/review.dart';
import 'package:my_app/screens/reviews_page.dart';
import 'package:my_app/model/company.dart';
import 'dart:math';

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

  Company company = Company(name: 'Mockup ITeration 1', reviews:[
  ]
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                child: Text('Rate Event 1'),
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
                child: Text('Rate Event 2'),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement see reviews functionality
                },
                child: Text('See Reviews'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EventRatingPage(company:company)),
                  );
                },
                child: Text('Rate Event 3'),
              ),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement see reviews functionality
                },
                child: Text('See Reviews'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}