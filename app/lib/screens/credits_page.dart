import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Credits:\n\nFrancisco Campos\nDiogo Silva\nJoão Figueiredo\nTiago Simões\nPedro Plácido',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}