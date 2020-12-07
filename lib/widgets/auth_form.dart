import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFN,
    this._isLoading,
  );

  final bool _isLoading;
  final void Function(
          String email, String name, String pw, bool isLogIn, BuildContext ctx)
      submitFN;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isLogin = true;
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPw = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    print(isValid);
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFN(
        _userEmail.trim(),
        _userName.trim(),
        _userPw.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // E-Mail Form
                    TextFormField(
                      key: ValueKey('email'),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter valid email!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'E-Mail',
                      ),
                      onSaved: (newValue) {
                        _userEmail = newValue;
                      },
                    ),
                    if (!_isLogin)
                      // Name
                      TextFormField(
                        key: ValueKey('name'),
                        validator: (value) {
                          if (value.isEmpty || (value.length <= 4)) {
                            return 'Please enter valid name!';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                        onSaved: (newValue) {
                          _userName = newValue;
                        },
                      ),
                    // PW
                    TextFormField(
                      key: ValueKey('pw'),
                      validator: (value) {
                        if (value.isEmpty || (value.length <= 7)) {
                          return 'Please enter valid password!';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      onSaved: (newValue) {
                        _userPw = newValue;
                      },
                      obscureText: true,
                    ),
                    // Button Section
                    SizedBox(height: 12),
                    if (widget._isLoading == true) CircularProgressIndicator(),
                    if (!widget._isLoading == true)
                      RaisedButton(
                        onPressed: _trySubmit,
                        child: _isLogin ? Text('Login') : Text('Sign Up'),
                      ),
                    if (!widget._isLoading == true)
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: _isLogin
                            ? Text('create new Account')
                            : Text('I have an account!'),
                      ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
