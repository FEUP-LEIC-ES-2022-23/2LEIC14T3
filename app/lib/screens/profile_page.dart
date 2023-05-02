import 'package:flutter/material.dart';

import '../model/user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.user,
  });
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage('https://source.unsplash.com/random/200x200?people'),
          ),
          const SizedBox(height: 16),
          Text('${user.firstName} ${user.lastName}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text('@${user.username}'),
          const SizedBox(height: 16),
          Text('${user.description}',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email),
              const SizedBox(width: 8),
              Text('${user.email}'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.link),
              const SizedBox(width: 8),
              const Text('www.johnsmith.com'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.phone),
              const SizedBox(width: 8),
              const Text('+1 123-456-7890'),
            ],
          ),
        ],
      ),
    );
  }
}