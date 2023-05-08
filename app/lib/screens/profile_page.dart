import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_it/auth/Authentication.dart';
import 'package:rate_it/cloud_storage/cloud_storage.dart';
import 'package:rate_it/model/review.dart';
import 'package:rate_it/screens/settings.dart';
import 'package:rate_it/widgets/review_card.dart';
import '../firestore/database.dart';
import '../model/user.dart';
import '../screens/settings-subclasses.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({
    Key? key,
    this.user,
  }) : super(key: key);

  User? user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  PlatformFile? pickedFile;

  String uid = Authentication.auth.currentUser!.uid;

  Future selectFile() async{
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.user!.firstName}'s Profile"),
          actions: [
            if(uid == widget.user!.uid)
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => SettingsPage(user: widget.user!),
                  )).then((_) async {
                    User updated = await Database.getUser(uid);
                    setState(() {
                      widget.user = updated;
                    });
                  });
                },
                icon: Icon(FontAwesomeIcons.gear),
              ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(widget.user!.photoURL),
                  ),
                  if (uid == widget.user!.uid)
                    Positioned(
                      bottom: 0,
                      right: 5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                            padding: EdgeInsets.all(10),
                            backgroundColor: Colors.white30,
                        ),
                        onPressed: () async {
                          await selectFile();
                          CloudStorage cs = CloudStorage(pickedFile: pickedFile);
                          String url = await cs.uploadImage();
                          Database.updateUserPhotoURL(uid, url);
                          setState(() {
                            widget.user!.photoURL = url;
                          });
                          // Add code to remove profile photo
                        },
                        child: Icon(FontAwesomeIcons.plus),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '${widget.user!.firstName} ${widget.user!.lastName}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('@${widget.user!.username}'),
              const SizedBox(height: 16),
              Text(
                '${widget.user!.description}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email),
                  const SizedBox(width: 8),
                  Text('${widget.user!.email}'),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if(widget.user!.phone != "")
                    Icon(Icons.phone),
                  if(widget.user!.phone != "")
                    const SizedBox(width: 8),
                  if(widget.user!.phone != "")
                    Text(widget.user!.phone),
                ],
              ),

              const SizedBox(height: 8),

              if(widget.user!.isPrivate)
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),

                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'This user has set their profile to private',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),



              if(!widget.user!.isPrivate)
              SizedBox(
                height: 50,
                child: AppBar(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)
                    )
                  ),
                  bottom: TabBar(
                    tabs: const [
                      Tab(icon: Icon(FontAwesomeIcons.briefcase)),
                      Tab(icon: Icon(FontAwesomeIcons.graduationCap)),
                      Tab(icon: Icon(FontAwesomeIcons.solidCalendarDays)),
                    ],
                  ),
                ),
              ),

              if(!widget.user!.isPrivate)
              Expanded(
                child: TabBarView(
                  children: [
                    for (int i=0; i<3; i++)
                      FutureBuilder(
                        future: Database.getUserReviews(widget.user!.uid, i),
                        builder: (context, snapshot) {
                          if (snapshot.hasData){
                            List<Review> reviews = snapshot.data!;
                            return ListView.builder(
                              itemCount: reviews.length,
                              itemBuilder: (context, index) {
                                Review review = reviews[index];
                                if (widget.user!.uid == uid || !review.anonymous) {
                                  return ReviewCard(review: review);
                                }
                                return null;
                              },
                            );
                          }
                          else if (snapshot.hasError) {
                            return const Text('Something went wrong!');
                          }
                          else {
                            return const Center(child:CircularProgressIndicator());
                          }
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
