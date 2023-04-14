import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class TopTabBar extends StatelessWidget implements PreferredSizeWidget {
  const TopTabBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: TabBar(
        tabs: [
          Tab(icon: Icon(FontAwesomeIcons.briefcase)),
          Tab(icon: Icon(FontAwesomeIcons.graduationCap)),
          Tab(icon: Icon(FontAwesomeIcons.solidCalendarDays)),
        ],
      ),
    );
  }
}
