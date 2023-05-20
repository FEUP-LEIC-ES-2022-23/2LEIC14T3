import 'package:flutter/material.dart';
import 'package:rate_it/auth/Authentication.dart';
import '../firestore/database.dart';
import '../model/user.dart';
import 'package:rate_it/auth/validation.dart';

class ChangeName extends StatefulWidget {
  const ChangeName({super.key});


  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Name'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                        prefixIcon: Icon(Icons.person),
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
                        prefixIcon: Icon(Icons.person),
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
              ElevatedButton(
                onPressed: () async {
                  String uid = Authentication.auth.currentUser!.uid;
                  if (_formKey.currentState!.validate()) {
                    String firstName = _firstNameController.text;
                    String lastName = _lastNameController.text;
                    Database.updateName(uid, firstName, lastName);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save changes'),
              ),
            ]
          ),
        ),
      ),
    );
  }
}




class ChangeBio extends StatefulWidget {
  const ChangeBio({super.key});


  @override
  State<ChangeBio> createState() => _ChangeBioState();
}

class _ChangeBioState extends State<ChangeBio> {
  TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Biography'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Biography',
                  prefixIcon: Icon(Icons.edit),
                  border: OutlineInputBorder(),
                ),
                controller: _bioController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 5,
              ),
              ElevatedButton(
                onPressed: () async {
                  String uid = Authentication.auth.currentUser!.uid;
                  String bio = _bioController.text;
                  Database.updateBio(uid, bio);
                  Navigator.pop(context);
                },
                child: Text('Save changes'),
              ),
            ],
        ),
      ),
    );
  }
}

class ChangeUsername extends StatefulWidget {
  const ChangeUsername({super.key});

  @override
  State<ChangeUsername> createState() => _ChangeUsernameState();
}

class _ChangeUsernameState extends State<ChangeUsername> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();

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
      appBar: AppBar(
        title: Text('Change Username'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.edit),
                    border: OutlineInputBorder(),
                  ),
                  controller: _usernameController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }                    if(usedUsername){
                      return 'Username already taken';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    checkUsername(value);
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    String uid = Authentication.auth.currentUser!.uid;
                    if (_formKey.currentState!.validate()) {
                      String username = _usernameController.text;
                      Database.updateUsername(uid, username);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Save changes'),
                ),
              ],
            ),
        ),
      ),
    );
  }
}

class ChangeEmail extends StatefulWidget {
  const ChangeEmail({Key? key}) : super(key: key);

  @override
  State<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();

  bool _usedEmail = false;

  Future<void> _checkEmail(String value) async {
    bool ans = await Validation.usedEmail(value);
    setState(() {
      _usedEmail = ans;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Email'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (Validation.emptyField(value)) {
                    return 'Please enter your email';
                  }
                  if (Validation.invalidEmail(value)) {
                    return 'Please enter a valid email address';
                  }
                  if (_usedEmail) {
                    return 'Email address already in use';
                  }
                  return null;
                },
                onChanged: (value) {
                  _checkEmail(value);
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  String uid = Authentication.auth.currentUser!.uid;
                  if (_formKey.currentState!.validate()) {
                    String email = _emailController.text;
                    Database.updateEmail(uid, email);
                    await Authentication.auth.currentUser!.updateEmail(email);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Current Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                controller: _currentPasswordController,
                obscureText: true,
                validator: (value) {
                  if (Validation.emptyField(value)) {
                    return 'Please enter your current password';
                  }
                  // Add your own validation logic here if needed
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'New Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                controller: _newPasswordController,
                obscureText: true,
                validator: (value) {
                  if (Validation.emptyField(value)) {
                    return 'Please enter a new password';
                  }
                  // Add your own validation logic here if needed
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                controller: _confirmPasswordController,
                obscureText: true,
                validator: (value) {
                  if (Validation.emptyField(value)) {
                    return 'Please confirm your new password';
                  }
                  if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String newPassword = _newPasswordController.text;
                    String confirmPassword = _confirmPasswordController.text;
                    String currentPassword = _currentPasswordController.text;

                    // Compare the current password with the stored password hash
                    bool isCurrentPasswordValid = await Authentication.verifyPassword(currentPassword);
                    if (!isCurrentPasswordValid) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Password Change Failed'),
                          content: Text('The current password entered is incorrect.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                      return;
                    }

                    // Continue with the password change logic
                    await Authentication.auth.currentUser!.updatePassword(newPassword);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save changes'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}




class ChangePhone extends StatefulWidget {
  const ChangePhone({super.key});


  @override
  State<ChangePhone> createState() => _ChangePhoneState();
}

class _ChangePhoneState extends State<ChangePhone> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Phone'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                minLines: 1,
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if(Validation.invalidPhone(value)){
                    return 'Enter valid PT phone number';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  if(_formKey.currentState!.validate()){
                    String uid = Authentication.auth.currentUser!.uid;
                    String phone = _phoneController.text;
                    Database.updatePhone(uid, phone);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class SettingsPage1 extends StatefulWidget {
  const SettingsPage1({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  State<SettingsPage1> createState() => _SettingsPageState1();
}

class _SettingsPageState1 extends State<SettingsPage1> {
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
