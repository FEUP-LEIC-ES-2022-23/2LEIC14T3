import 'package:flutter/material.dart';
import 'package:rate_it/auth/Authentication.dart';
import '../firestore/database.dart';
import '../model/user.dart';
import 'package:rate_it/auth/validation.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool usedUsername = false;

  Future<void> checkUsername(String value) async {
    bool ans = await Validation.usedUsername(value);
    setState(() {
      usedUsername = ans;
    });

  }

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.user.firstName;
    _lastNameController.text = widget.user.lastName;
    _usernameController.text = widget.user.username;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form (
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  hintText: 'Enter your first name',
                  border: OutlineInputBorder(),

                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 8),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  hintText: 'Enter your last name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),

                validator: (value) {
                  if (Validation.emptyField(value)) {
                    return 'Please enter your password';
                  }
                  if (Validation.shortPassword(value)) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter a new password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                  // Update user profile with new info
                  String uid = Authentication.auth.currentUser!.uid;
                  String firstName = _firstNameController.text;
                  String lastName = _lastNameController.text;
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  if (firstName != widget.user.firstName ||
                      lastName != widget.user.lastName) {
                    Database.updateName(uid, firstName, lastName);
                    setState(() {
                      widget.user.firstName = firstName;
                      widget.user.lastName = lastName;
                    });
                  }
                  if (username != widget.user.username) {
                    await checkUsername(username);
                    if(!usedUsername){
                      Database.updateUsername(uid, username);
                    }
                  }
                  if (password.isNotEmpty) {
                    //Authentication.updatePassword(password);
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
