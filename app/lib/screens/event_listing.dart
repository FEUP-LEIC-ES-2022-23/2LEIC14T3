import 'package:flutter/material.dart';

import '../model/event.dart';

class EventListing extends StatelessWidget {
  late Future<List<Event>> futureCompanies = fetchEvents(limit: 10);
  EventListing({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:futureCompanies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Event> events = snapshot.data!;
          return Center(
            child: ListView(
              children: [
                for(var event in events)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                        },
                        child: Text(event.title),
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
    );
  }
}