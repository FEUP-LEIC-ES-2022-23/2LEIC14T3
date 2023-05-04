import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rate_it/screens/settings-subclasses.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDark = false;
  bool _isPriv = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDark ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            child: ListView(
              children: [
                _SingleSection(
                  title: "General",
                  children: [
                    _CustomListTile(
                        title: "Dark Mode",
                        icon: FontAwesomeIcons.moon,
                        trailing: Switch(
                            value: _isDark,
                            onChanged: (value) {
                              setState(() {
                                _isDark = value;
                              });
                            })),
                    _CustomListTile(
                        title: "Private Profile",
                        icon: FontAwesomeIcons.shieldHalved,
                        trailing: Switch(
                        value: _isPriv,
                        onChanged: (value) {
                          setState(() {
                            _isPriv = value;
                          });
                      })
                    ),
                  ],
                ),
                const Divider(),
                _SingleSection(
                  title: "Edit Profile",
                  children: [
                    _CustomListTile(
                        title: "Change Name", icon: FontAwesomeIcons.addressCard,
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChangeName(),
                            ),
                          );
                      },
                    ),
                    _CustomListTile(
                      title: "Change Biography", icon: FontAwesomeIcons.pencil,
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChangeBio(),
                          ),
                        );
                      },
                    ),
                    _CustomListTile(
                      title: "Change Phone", icon: FontAwesomeIcons.phone,
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChangePhone(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Divider(),
                const _SingleSection(
                  title: "Security",
                  children: [
                    _CustomListTile(
                        title: "Change Email", icon: FontAwesomeIcons.envelope),
                    _CustomListTile(
                        title: "Change Username", icon: FontAwesomeIcons.user),
                    _CustomListTile(
                        title: "Change Password", icon: FontAwesomeIcons.key),
                  ],
                ),
                const Divider(),
                const _SingleSection(
                  children: [
                    _CustomListTile(
                        title: "Sign out", icon: FontAwesomeIcons.arrowRightFromBracket),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final void Function()? onTap;
  const _CustomListTile(
      {Key? key, required this.title, required this.icon, this.trailing, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Column(
          children: children,
        ),
      ],
    );
  }
}