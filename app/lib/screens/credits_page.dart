import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children:[Text(
          'Credits:\n\nFrancisco Campos\nDiogo Silva\nJoão Figueiredo\nTiago Simões\nPedro Plácido',
          style: TextStyle(fontSize: 24),
        ),]
      ),
    );
  }
}