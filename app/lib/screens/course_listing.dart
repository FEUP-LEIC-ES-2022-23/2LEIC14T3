import 'package:flutter/material.dart';
import '../model/course.dart';
import '../screens/course_page.dart';
import '../widgets/courseCard.dart';

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
      future: futureCourses,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Course> courses = snapshot.data!;

          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              Course course = courses[index];
              return CourseCard(course: course);
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
