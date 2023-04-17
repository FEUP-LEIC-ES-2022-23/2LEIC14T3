import 'package:flutter/material.dart';
import '../model/event.dart';

class EventScreen extends StatefulWidget {
  final Event event;

  EventScreen({required this.event});

  @override
  _EventScreenState createState() => _EventScreenState();

}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.event.title),
            Text(widget.event.description),
            Text(widget.event.dateStart.toString()),
            Text(widget.event.dateEnd.toString()),
            Text(widget.event.place),
            Text(widget.event.email),
            Text(widget.event.url),
            Text(widget.event.isPaid.toString()),
            Text(widget.event.updatedAt.toString()),
          ],
        ),
      ),
    );
  }
}