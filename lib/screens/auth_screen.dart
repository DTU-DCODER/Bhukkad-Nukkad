import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../models/http_exception.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.cyan[400]!.withOpacity(0.5),
                  Colors.blue[50]!.withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: deviceSize.height * 0.22,
                    child: Stack(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: deviceSize.width * 0.2,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.shop,
                              size: deviceSize.width * 0.3,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "My Shop",
                            style: TextStyle(
                              fontFamily: "Anton",
                              fontSize: deviceSize.height * 0.05,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //SizedBox(height: deviceSize.height * 0.02),

                  SizedBox(height: deviceSize.height * 0.03),
                  AuthCard(deviceSize),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  final Size deviceSize;
  const AuthCard(
    this.deviceSize, {
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String?> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  var _showError = false;
  String? errorMessage;
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  late AnimationController _controller;
  late Animation<Size> _heightAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _heightAnimation = Tween<Size>(
            begin: Size(double.infinity, widget.deviceSize.height * 0.41),
            end: Size(double.infinity, widget.deviceSize.height * 0.5))
        .animate(
      CurvedAnimation(parent: _controller, curve: Curves.decelerate),
    );
    _heightAnimation.addListener(() => {setState(() {})});
    super.initState();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
      }
      setState(() {
        _showError = false;
        _isLoading = false;
      });
    } on HttpException catch (error) {
      errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      print(errorMessage);
      setState(() {
        _showError = true;
        _isLoading = false;
        _passwordController.text = "";
      });
    } catch (error) {
      errorMessage = 'Could not authenticate you. Please try again later.';
      setState(() {
        _showError = true;
        _isLoading = false;
        _passwordController.text = "";
      });
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
        _showError = false;
        _passwordController.text = "";
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
        _showError = false;
        _passwordController.text = "";
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        // height: _authMode == AuthMode.Login
        //     ? deviceSize.height * 0.4
        //     : deviceSize.height * 0.45,
        height: _heightAnimation.value.height,
        constraints: BoxConstraints(minHeight: _heightAnimation.value.height),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(deviceSize.height * 0.02),
        child: Form(
          onWillPop: () => Future.value(true),
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Center(
                child: Text(
                  _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: deviceSize.height * 0.03,
                      ),
                ),
              ),
              if (_showError)
                Padding(
                  padding: EdgeInsets.all(deviceSize.height * 0.01),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: deviceSize.height * 0.02,
                    ),
                  ),
                ),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-Mail'),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['email'] = value;
                },
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 5) {
                    return 'Password is too short!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _authData['password'] = value;
                },
                textInputAction: (_authMode == AuthMode.Signup)
                    ? TextInputAction.next
                    : TextInputAction.done,
                onFieldSubmitted:
                    (_authMode == AuthMode.Signup) ? null : (_) => _submit(),
              ),
              if (_authMode == AuthMode.Signup)
                TextFormField(
                  enabled: _authMode == AuthMode.Signup,
                  decoration: InputDecoration(labelText: 'Confirm Password'),
                  obscureText: true,
                  validator: _authMode == AuthMode.Signup
                      ? (value) {
                          if (value != _passwordController.text) {
                            return 'Passwords do not match!';
                          }
                          return null;
                        }
                      : null,
                  textInputAction: (_authMode == AuthMode.Signup)
                      ? TextInputAction.done
                      : null,
                  onFieldSubmitted:
                      (_authMode == AuthMode.Signup) ? (_) => _submit() : null,
                ),
              if (_isLoading)
                CircularProgressIndicator()
              else
                ElevatedButton(
                  child:
                      Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    onPrimary: Colors.white,
                    padding: EdgeInsets.symmetric(
                        horizontal: deviceSize.width * 0.05,
                        vertical: deviceSize.height * 0.01),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              TextButton(
                child: Text(
                    '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                onPressed: _switchAuthMode,
                style: TextButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  padding: EdgeInsets.symmetric(
                      horizontal: deviceSize.width * 0.05,
                      vertical: deviceSize.height * 0.01),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
