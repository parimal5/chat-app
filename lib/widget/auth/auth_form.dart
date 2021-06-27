import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
    }

    //! Auth Request
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Login/SignUp',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value.isEmpty || value.contains('@')) {
                        return 'Please Enter valid Email';
                      }
                      return null;
                    },
                    onSaved: (inputEmail) {
                      _userEmail = inputEmail;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Username must be atleast 5 Character';
                      }
                      return null;
                    },
                    onSaved: (inputUserName) {
                      _userName = inputUserName;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    validator: (pass) {
                      if (pass.isEmpty || pass.length < 7) {
                        return 'Password too week';
                      }
                      return null;
                    },
                    onSaved: (inputPassword) {
                      _userPassword = inputPassword;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  ElevatedButton.icon(
                    onPressed: _trySubmit,
                    icon: Icon(Icons.login),
                    label: Text('Login'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.swap_horiz),
                    label: Text("Create New Account"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
