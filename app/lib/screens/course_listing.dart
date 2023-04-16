import 'package:flutter/material.dart';

import '../model/course.dart';

class CourseListing extends StatelessWidget {
  final String searchResult;
  CourseListing({
    super.key,
    required this.searchResult,
  });
  late Future<List<Course>> futureCourses;

  void initCourses(){
    if(searchResult.length>1){
      futureCourses = searchCourses(searchResult);
    }
    else {
      futureCourses = fetchCourses();
    }
  }

  @override
  Widget build(BuildContext context) {
    initCourses();
    return FutureBuilder(
      future:futureCourses,
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
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}