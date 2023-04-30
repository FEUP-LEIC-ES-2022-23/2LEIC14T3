import 'package:flutter/material.dart';
import '../model/course.dart';
import '../screens/course_page.dart';

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
          return Center(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                Course course = courses[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseScreen(course: course),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    color: Colors.blue[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.title,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            course.body,
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Start date: ${course.dateStart}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'End date: ${course.dateEnd}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Place: ${course.place}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Email: ${course.contactEmail}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'URL: ${course.url}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Price: ${course.price}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Updated at: ${course.updatedAt}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
