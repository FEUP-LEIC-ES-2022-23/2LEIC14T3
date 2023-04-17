import 'package:flutter/material.dart';
import '../model/event.dart';
import '../screens/event_page.dart';

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
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventScreen(event: events[index]),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Colors.blue[50],
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          events[index].title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Date: ${events[index].dateStart}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Location: ${events[index].place}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Email: ${events[index].email}',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
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

