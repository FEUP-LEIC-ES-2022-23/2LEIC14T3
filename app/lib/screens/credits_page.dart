import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("CreditsPage"),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            children: const [
              Text(
                'Credits',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              SizedBox(height: 32),
              CreditItem(icon: Icons.person, name: 'Francisco Campos'),
              SizedBox(height: 8),
              CreditItem(icon: Icons.person, name: 'Diogo Silva'),
              SizedBox(height: 8),
              CreditItem(icon: Icons.person, name: 'João Figueiredo'),
              SizedBox(height: 8),
              CreditItem(icon: Icons.person, name: 'Tiago Simões'),
              SizedBox(height: 8),
              CreditItem(icon: Icons.person, name: 'Pedro Plácido'),
            ],
          ),
        ),
      ),
    );
  }
}

class CreditItem extends StatelessWidget {
  final IconData icon;
  final String name;

  const CreditItem({required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 32, color: Colors.blue),
        const SizedBox(width: 8),
        Text(name, style: const TextStyle(fontSize: 24)),
      ],
    );
  }
}
