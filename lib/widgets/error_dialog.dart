import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/services/auth.dart';
import 'package:notes/services/database.dart';

const Color colorMain = Color(0xff2b3139);
const Color colorSecondary = Color(0xff7d7d84);
const Color colorThird = Color(0xffffffff);
const Color colorFourth = Color(0xffff286c);
void dialog(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.light(),
          child: AlertDialog(
            elevation: 20,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            title: Text('Error'),
            content: Text(message),
            actions: [
              CupertinoButton(
                child: Text(
                  'Back',
                  style: TextStyle(color: colorFourth),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      });
}

// ignore: missing_return
Future<void> passwordRestdialog(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.light(),
          child: AlertDialog(
            elevation: 20,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            title: Text('Forgot Password'),
            content: Text(message),
            actions: [
              CupertinoButton(
                child: Text(
                  'Back',
                  style: TextStyle(color: colorFourth),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      });
}

void deltedialog(BuildContext context, String id, Database database) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.light(),
          child: AlertDialog(
            elevation: 20,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            title: Text('Alert'),
            content: Text('Do you want to delete this note'),
            actions: [
              CupertinoButton(
                child: Text(
                  'Back',
                  style: TextStyle(color: colorFourth),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoButton(
                  child: Text(
                    'Delete',
                    style: TextStyle(color: colorFourth),
                  ),
                  onPressed: () async {
                    await database.deletePost(postID: id);
                    Navigator.pop(context);

                  }),
            ],
          ),
        );
      });
}




Future<void> logoutdialogX(BuildContext context, AuthBase auth) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData.light(),
          child: AlertDialog(
            elevation: 20,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            title: Text('Notes'),
            content: Text('Do you want to Logout'),
            actions: [
              CupertinoButton(
                child: Text(
                  'Back',
                  style: TextStyle(color: colorFourth),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoButton(
                  child: Text(
                    'Logout',
                    style: TextStyle(color: colorFourth),
                  ),
                  onPressed: () {
                    auth.signOut();
                    Navigator.pop(context);
                  }),
            ],
          ),
        );
      });
}
