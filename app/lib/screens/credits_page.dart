import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 24),
        const Text(
          'Credits:',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 24),
        const Center(child: Text('Francisco Campos', style: TextStyle(fontSize: 24))),
        const Center(child: Text('Diogo Silva', style: TextStyle(fontSize: 24))),
        const Center(child: Text('João Figueiredo', style: TextStyle(fontSize: 24))),
        const Center(child: Text('Tiago Simões', style: TextStyle(fontSize: 24))),
        const Center(child: Text('Pedro Plácido', style: TextStyle(fontSize: 24))),
      ],
    );
  }
}
