import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_it/auth/Authentication.dart';
import 'package:rate_it/cloud_storage/cloud_storage.dart';
import '../firestore/database.dart';
import '../model/user.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

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
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.user.firstName}'s Profile"),
        actions: [
          if(uid == widget.user.uid)
            IconButton(
              onPressed: () {
                // TODO CHANGE NAME, CHANGE USERNAME, CHANGE PASSWORD, ...
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
                  backgroundImage: NetworkImage(widget.user.photoURL),
                ),
                if (uid == widget.user.uid)
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
                          widget.user.photoURL = url;
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
              '${widget.user.firstName} ${widget.user.lastName}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('@${widget.user.username}'),
            const SizedBox(height: 16),
            Text(
              '${widget.user.description}',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email),
                const SizedBox(width: 8),
                Text('${widget.user.email}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(widget.user.phone != "")
                  Icon(Icons.phone),
                if(widget.user.phone != "")
                  const SizedBox(width: 8),
                if(widget.user.phone != "")
                  Text(widget.user.phone),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
