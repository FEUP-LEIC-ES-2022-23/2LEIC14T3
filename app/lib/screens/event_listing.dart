import 'package:flutter/material.dart';

import '../model/event.dart';

class EventListing extends StatelessWidget {
  final String searchResult;
  EventListing({
    super.key,
    required this.searchResult,
  });
  late Future<List<Event>> futureEvents = fetchEvents(limit: 10);

  void initEvents(){
    if(searchResult!=""){
      futureEvents = fetchEvents(limit: 10);
    }
    else {
      futureEvents = fetchEvents(limit: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:futureEvents,
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
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}