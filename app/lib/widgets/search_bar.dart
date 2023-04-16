import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoundedSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;

  RoundedSearchBar({
    Key? key,
    required this.controller,
    required this.onSubmitted
  }) : super(key: key);

  @override
  _RoundedSearchBarState createState() => _RoundedSearchBarState();
}

class _RoundedSearchBarState extends State<RoundedSearchBar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: IconButton(
              icon: Icon(FontAwesomeIcons.search),
            onPressed: () {
                widget.onSubmitted(widget.controller.text);
            },
          ),
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.grey[600]),
          border: InputBorder.none,
          suffixIcon: widget.controller.text.isNotEmpty ? IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              widget.controller.clear();
            },
          )
              : null,
        ),
        onSubmitted:widget.onSubmitted,
      ),
    );
  }
}
