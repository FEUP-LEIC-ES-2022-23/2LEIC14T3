import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoundedSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final Icon icon;

  RoundedSearchBar({
    this.controller,
    required this.hintText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 40.0,
      width: width*2/3,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600]),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

