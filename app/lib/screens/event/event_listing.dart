import 'package:flutter/material.dart';
import '../../model/event.dart';
import '../../widgets/eventCard.dart';

class EventListing extends StatelessWidget {

  final String searchResult;
  EventListing({
    super.key,
    required this.searchResult,
  });
  late Future<List<Event>> futureEvents;

  void initEvents(){
    if(searchResult.length>1){
      futureEvents = searchEvents(searchResult);
    }
    else {
      futureEvents = fetchEvents();
    }
  }

  @override
  Widget build(BuildContext context) {
    initEvents();
    return FutureBuilder(
      future: futureEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Event> events = snapshot.data!;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              Event event = events[index];
              return EventCard(event: event);
            },
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