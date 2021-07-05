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
    final height = deviceSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
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
              height: height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: height * 0.22,
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
                              fontSize: height * 0.05,
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
                  //SizedBox(height: height * 0.02),

                  SizedBox(height: height * 0.03),
                  AuthCard(),
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
  //final Size deviceSize;
  const AuthCard(
      //this.deviceSize,
      {
    Key? key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with TickerProviderStateMixin {
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
  final _confirmPasswordController = TextEditingController();
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  late AnimationController _errorAnimationController;
  late Animation<Offset> _errorAnimation;
  late Animation<double> _errorOpacityAnimation;
  @override
  void initState() {
    _showError = false;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _errorAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    _errorOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _errorAnimationController,
        curve: Curves.easeIn,
      ),
    );
    _errorAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _errorAnimationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    // _heightAnimation.addListener(() => {setState(() {})});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _passwordController.dispose();
_emailController.dispose();  
_confirmPasswordController.dispose();
_errorAnimationController.dispose();
  }

  void _submit() async {
    await _errorAnimationController.reverse();
    setState(() {
      _showError = false;
    });

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
        _confirmPasswordController.text = "";
      });
      _errorAnimationController.forward();
    } catch (error) {
      errorMessage = 'Could not authenticate you. Please try again later.';
      setState(() {
        _showError = true;
        _isLoading = false;
        _passwordController.text = "";

        _confirmPasswordController.text = "";
      });

      _errorAnimationController.forward();
    }
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
        _showError = false;
        _formKey.currentState?.reset();
        _passwordController.text = "";

        _confirmPasswordController.text = "";
      });
      print("controller forward");
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
        _showError = false;
        _formKey.currentState?.reset();
        _passwordController.text = "";

        _confirmPasswordController.text = "";
      });
      print("controller reverse");
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final height = deviceSize.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.Login ? height * 0.495 : height * 0.62,
        // height: _heightAnimation.value.height,
        constraints: BoxConstraints(
            minHeight:
                _authMode == AuthMode.Login ? height * 0.495 : height * 0.62),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(height * 0.02),
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
                        fontSize: height * 0.03,
                      ),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: _showError == true ? height * 0.03 : 0,
                child: FadeTransition(
                  opacity: _errorOpacityAnimation,
                  child: SlideTransition(
                    position: _errorAnimation,
                    child: errorMessage != null
                        ? Padding(
                            padding: EdgeInsets.all(height * 0.005),
                            child: Text(
                              errorMessage!,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: height * 0.02,
                              ),
                            ),
                          )
                        : SizedBox(height: 0),
                  ),
                ),
              ),
              Container(
                height: height * 0.12,
                child: TextFormField(
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
              ),
              Container(
                height: height * 0.12,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
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
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: _authMode == AuthMode.Signup ? height * 0.12 : 0,
                child: FadeTransition(
                  opacity: _opacityAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      controller: _confirmPasswordController,
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
                      onFieldSubmitted: (_authMode == AuthMode.Signup)
                          ? (_) => _submit()
                          : null,
                    ),
                  ),
                ),
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
                        vertical: height * 0.01),
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
                      vertical: height * 0.01),
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
