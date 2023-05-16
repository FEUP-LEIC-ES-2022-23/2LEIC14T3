import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(height: 24),
        Text(
          'Credits:',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 24),
        Center(child: Text('Francisco Campos', style: TextStyle(fontSize: 24))),
        Center(child: Text('Diogo Silva', style: TextStyle(fontSize: 24))),
        Center(child: Text('João Figueiredo', style: TextStyle(fontSize: 24))),
        Center(child: Text('Tiago Simões', style: TextStyle(fontSize: 24))),
        Center(child: Text('Pedro Plácido', style: TextStyle(fontSize: 24))),
      ],
    );
  }
}
