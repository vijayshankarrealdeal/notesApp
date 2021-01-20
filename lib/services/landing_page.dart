import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes/login/signIn.dart';
import 'package:notes/material-Design/homepage.dart';
import 'package:notes/model/hoemDb.dart';
import 'package:notes/model/userdetails.dart';
import 'package:notes/services/auth.dart';
import 'package:notes/services/database.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return StreamBuilder<Object>(
      stream: auth.onAuthChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          if (user == null) {
            return SignIn();
          } else {
            return Provider(
              create: (context) => Database(uid: user.uid, email: user.email),
              child: TakeHome(),
            );
          }
        }
        return CupertinoActivityIndicator();
      },
    );
  }
}

class TakeHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<UserDetails>>(
        stream: database.userStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data.contains(database.uid)) {
              database.createUser(
                  create: UserDetails(
                uid: database.uid,
                email: database.email,
              ));
            }
            return MultiProvider(providers: [
              Provider<UserDetails>(
                create: (context) =>
                    UserDetails(uid: database.uid, email: database.email),
              ),
              StreamProvider<List<HomeDB>>(
                initialData: [],
                create:(context)=> database.notesStream(),),
            ], child: MaterialHomePage());
          } else {
            return CupertinoActivityIndicator();
          }
        });
  }
}
