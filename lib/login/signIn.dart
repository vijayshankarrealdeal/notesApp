import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/services/auth.dart';
import 'package:notes/widgets/error_dialog.dart';
import 'package:notes/widgets/textForm.dart';
import 'package:provider/provider.dart';

const Color colorMain = Color(0xff2b3139);
const Color colorSecondary = Color(0xff7d7d84);
const Color colorThird = Color(0xffffffff);
const Color colorFourth = Color(0xffff286c);
enum SignOptions { signIn, signUp, forgetPass }

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  SignOptions _formType = SignOptions.signIn;
  bool isSpin = true;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final String primaryText =
        _formType == SignOptions.signIn ? "Sign In " : "Sign Up";
    final String secondaryText = _formType == SignOptions.signIn
        ? "Need a Account ? Sign Up"
        : "Already Have An Account";
    final auth = Provider.of<AuthBase>(context);
    return Scaffold(
      backgroundColor: colorThird,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Notes',
              style: TextStyle(
                color: colorFourth,
                fontFamily: 'Lato-Thin',
                fontSize: MediaQuery.of(context).size.height * 0.1,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Container(
              width: double.infinity,
            ),
            TextForms(
              isspin: isSpin,
              enter: _email,
              placeholder: "Email Address",
              hide: false,
            ),
            SizedBox(height: 8.0),
            TextForms(
              isspin: isSpin,
              enter: _password,
              placeholder: "Password",
              hide: true,
            ),
            SizedBox(height: 8.0),
            _formType == SignOptions.signUp
                ? TextForms(
                    isspin: isSpin,
                    enter: _confirmPassword,
                    placeholder: "Confirm Password",
                    hide: true,
                  )
                : Text(''),
            SizedBox(height: 15.0),
            isSpin
                ? CupertinoButton(
                    color: colorMain,
                    child: Text(primaryText),
                    onPressed: () => submit(_email.text.trim(), _password.text,
                        _confirmPassword.text, auth),
                  )
                : CupertinoActivityIndicator(),
            SizedBox(height: 1.0),
            CupertinoButton(
                child: Text(
                  secondaryText,
                  style: TextStyle(
                      fontFamily: 'Lato-Bold',
                      color: CupertinoColors.activeBlue),
                ),
                onPressed: () {
                  setState(() {
                    _formType = _formType == SignOptions.signIn
                        ? SignOptions.signUp
                        : SignOptions.signIn;
                  });
                  _email.clear();
                  _password.clear();
                }),
            _formType == SignOptions.signIn
                ? CupertinoButton(
                    child: Text(
                      'Forget Password',
                      style: TextStyle(color: colorMain),
                    ),
                    onPressed: () => forgetPass(context, auth),
                    padding: EdgeInsets.only(top: 2),
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }

  void submit(String email, String password, String confirmPassword,
      AuthBase auth) async {
    if (_formType == SignOptions.signIn) {
      try {
        setState(() {
          isSpin = false;
        });
        await auth.signIn(email, password);
      } catch (e) {
        setState(() {
          isSpin = true;
        });
        dialog(context, e.message);
      }
    } else {
      if (password == confirmPassword) {
        try {
          setState(() {
            isSpin = false;
          });
          await auth.signUp(email, password);
        } catch (e) {
          setState(() {
            isSpin = true;
          });
          dialog(context, e.message);
        }
      } else {
        setState(() {
          isSpin = true;
        });
        dialog(context, 'Password not matched');
      }
    }
  }

  void forgetPass(BuildContext context, AuthBase auth) {
    TextEditingController _emailForget = TextEditingController();
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: Dialog(
            backgroundColor:colorThird,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Forget Password',
                    style: TextStyle(
                        color: colorFourth,
                        fontSize: 35.0,
                        fontFamily: 'Lato-Light'),
                  ),
                  SizedBox(height: 15.0),
                  TextForms(
                    isspin: isSpin,
                    enter: _emailForget,
                    placeholder: 'Email Address',
                    hide: false,
                  ),
                  SizedBox(height: 30.0),
                  CupertinoButton(
                      color: colorMain,
                      child: Text('Submit'),
                      onPressed: () async {
                        try {
                          setState(() {
                            isSpin = false;
                          });
                          await auth.forgotPassword(_emailForget.text);
                          passwordRestdialog(context,
                              'Rest password Link is sent on your email\ncheck your inbox');
                          _emailForget.clear();
                          setState(() {
                            isSpin = true;
                          });
                        } catch (e) {
                          setState(() {
                            isSpin = true;
                          });
                          dialog(context, e.message);
                        }
                      }),
                  SizedBox(
                    height: 8.0,
                  ),
                  CupertinoButton(
                    child: Text(
                      ' Back ',
                      style: TextStyle(color: colorFourth),
                    ),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
