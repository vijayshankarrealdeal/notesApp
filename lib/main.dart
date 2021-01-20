import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/camera.dart';
import 'package:notes/material-Design/change.dart';
import 'package:notes/services/auth.dart';
import 'package:notes/services/landing_page.dart';
import 'package:provider/provider.dart';

void main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<CameraAndFile>(
      create: (context) => CameraAndFile(), child: MyApp()));
}

bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<ChangeofPage>(create: (context)=>ChangeofPage(),),
          Provider<AuthBase>(
            create: (context) => Auth(),
          ),
        ],
        child: LandingPage(),
      ),
    );
  }
}
