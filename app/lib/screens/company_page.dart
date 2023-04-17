import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rate_it/screens/reviews_page.dart';
import '../model/company.dart';
import 'rating_page.dart';


class CompanyScreen extends StatefulWidget {
  final Company company;

  CompanyScreen({required this.company});

  @override
  _CompanyScreenState createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {

  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(milliseconds: 250), (timer) {
      updateAverageRating();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void updateAverageRating() {
    setState(() {
      widget.company.averageRating = widget.company.reviews.fold(0, (sum, review) => sum + review.rating) / widget.company.reviews.length;
      if(widget.company.averageRating.isNaN) widget.company.averageRating = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.company.name),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            height: 100,
            child: Image.network(widget.company.logo),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.company.name,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  widget.company.description,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 8.0),
                    Text(
                      widget.company.address,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.star),
                    SizedBox(width: 8.0),
                    Text(
                      widget.company.averageRating.toStringAsFixed(1),
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      '(${widget.company.reviews.length} reviews)',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventRatingPage(company: widget.company),
                          ),
                        );
                      },
                      child: Text('Rate this company'),

                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReviewsPage(company: widget.company),
                          ),
                        );
                      },
                      child: Text('Check Reviews'),
                    ),
                  ],

                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
