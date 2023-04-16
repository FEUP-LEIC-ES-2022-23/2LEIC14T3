import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
          const Text(
            'John Smith',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'I am a software engineer with 5 years of experience in mobile app development. '
                'I am passionate about creating high-quality, user-friendly apps that solve real-world problems.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email),
              const SizedBox(width: 8),
              const Text('john.smith@email.com'),
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