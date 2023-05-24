import 'package:flutter/material.dart';
import 'package:rate_it/auth/validation.dart';
import 'package:rate_it/screens/header_page.dart';
import '../auth/Authentication.dart';
import '../screens/register_page.dart';
import '../widgets/popup_message.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("LoginPage"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Login to ',
                  style: TextStyle(fontSize: 32.0, color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'RateIT',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 42.0),
              TextFormField(
                key: Key("emailfield"),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (Validation.emptyField(value)) {
                    return 'Please enter your email';
                  } else if (Validation.invalidEmail(value)) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                key: Key("passfield"),
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (Validation.emptyField(value)) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                key: Key("LoginButton"),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // perform login
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    String msg = await Authentication.login(email, password);
                    if (msg == "No user found for that email.") {
                      showDialog(
                        context: context,
                        builder: (_) => PopupMessage(
                          title: "Unknown User",
                          message: msg,
                        ),
                      );
                    } else if (msg == "Wrong password provided for that user.") {
                      showDialog(
                        context: context,
                        builder: (_) => PopupMessage(
                          title: "Wrong Credentials",
                          message: msg,
                        ),
                      );
                    } else if (msg == "successful-login") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                        ),
                      );
                    }
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


