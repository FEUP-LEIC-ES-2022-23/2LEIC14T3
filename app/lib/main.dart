import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/rating_page.dart';
import 'package:my_app/reviews_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

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
                    MaterialPageRoute(builder: (context) => EventRatingPage()),
                  );
                },
                child: Text('Rate Event 1'),
              ),
              ElevatedButton(
                onPressed: () {
                  List<Review> reviews = List.generate(
                    1,
                        (index) => Review(
                          title: 'AMAZING',
                        author: 'JOHN DOW',
                        rating: 5,
                        review: 'THIS IS A REALLY NICE IT COMPANY LOVED IT',
                        votes:0));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewsPage(reviews: reviews),
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
                    MaterialPageRoute(builder: (context) => EventRatingPage()),
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
                    MaterialPageRoute(builder: (context) => EventRatingPage()),
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




class CreditsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Credits:\n\nFrancisco Campos\nDiogo Silva\nJoão Figueiredo\nTiago Simões\nPedro Plácido',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}