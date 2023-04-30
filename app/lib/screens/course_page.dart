import 'package:flutter/material.dart';
import '../model/course.dart';

class CourseScreen extends StatefulWidget {
  final Course course;

  CourseScreen({required this.course});

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.course.title),
            Text(widget.course.body),
            Text(widget.course.dateStart.toString()),
            Text(widget.course.dateEnd.toString()),
            Text(widget.course.place),
            Text(widget.course.contactEmail),
            Text(widget.course.url),
            Text(widget.course.price.toString()),
            Text(widget.course.updatedAt.toString()),
          ],
        ),
      ),
    );
  }
}
