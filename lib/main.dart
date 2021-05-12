import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_flutter_map/LogInScreen.dart';
import 'package:simple_flutter_map/SignUpScreen.dart';

import 'package:simple_flutter_map/map_page.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LogInScreen.id,
      routes: {
        MapPage.id: (context) => MapPage(),
        //LocationList.id: (context) => LocationList(),
        LogInScreen.id:(context)=>LogInScreen(),
        SignUpScreen.id:(context)=>SignUpScreen(),

      },
    );
  }
}
