import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;

  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  AuthForm(this.submitFn, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
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
                    _isLogin ? ' Login ' : 'Create New Account',
                    style: TextStyle(
                      color: Colors.blueGrey.shade700,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please Enter valid Email';
                      }
                      return null;
                    },
                    onSaved: (inputEmail) {
                      _userEmail = inputEmail;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
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
                    key: ValueKey('password'),
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
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton.icon(
                      onPressed: _trySubmit,
                      icon: Icon(Icons.login),
                      label: Text(
                        _isLogin ? 'Login' : 'Signup',
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                      ),
                    ),
                  if (!widget.isLoading)
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      icon: _isLogin
                          ? Icon(Icons.account_circle_rounded)
                          : Icon(Icons.swap_horiz),
                      label: Text(_isLogin
                          ? "Create New Account"
                          : 'I already have an account'),
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
