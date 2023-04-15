import 'package:flutter/material.dart';

import '../model/course.dart';

class CourseListing extends StatelessWidget {
  late Future<List<Course>> futureCompanies = fetchCourses(limit: 10);
  CourseListing({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:futureCompanies,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Course> events = snapshot.data!;
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