import 'package:flutter/material.dart';
import 'package:rate_it/auth/Authentication.dart';
import 'package:rate_it/auth/validation.dart';
import 'package:rate_it/widgets/popup_message.dart';

import '../firestore/database.dart';
import '../model/user.dart';
import 'header_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool usedUsername = false;

  Future<void> checkUsername(String value) async {
    bool ans = await Validation.usedUsername(value);
    setState(() {
      usedUsername = ans;
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Register',
                style: TextStyle(fontSize: 32.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.0),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: TextFormField(
                        controller: _firstNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        controller: _lastNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Last Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),

              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (Validation.emptyField(value)) {
                    return 'Please enter your username';
                  }
                  if(usedUsername){
                    return '$value already in use';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (Validation.emptyField(value)) {
                    return 'Please enter your email';
                  }
                  if (Validation.invalidEmail(value)){
                    return 'Please insert valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
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
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () async {
                  await checkUsername(_usernameController.text);
                  if (_formKey.currentState!.validate()) {
                    String firstName = _firstNameController.text;
                    String lastName = _lastNameController.text;
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    String email = _emailController.text;
                    String msg = await Authentication.register(email, password);
                    if (msg == "The account already exists for that email.") {
                      showDialog(
                        context: context,
                        builder: (_) => PopupMessage(title: "Email",message: msg)
                      );
                    }
                    else if (msg == "successful-register"){
                      User user = User(
                          firstName: firstName, lastName: lastName,
                          username: username,
                          email: email);
                      Database.addUser(user);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ),
                      );
                    }
                  }
                },
                child: Text('Register'),
              ),

              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  // navigate to login page
                  Navigator.pop(context);
                },
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
