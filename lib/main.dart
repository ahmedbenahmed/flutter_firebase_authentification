import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase/screens/home_screen.dart';
import 'package:flutter_firebase/screens/login_screen.dart';
import 'package:flutter_firebase/services/auth_service.dart';

import 'screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      appId: "Your APP ID HERE", // Your appId
      projectId: "Your Project ID HERE", // Project ID
      apiKey: 'Your API KEY HERE', // Your API KEY HERE
      messagingSenderId: 'Your SENDER ID HERE', // Your projectId
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: AuthService().auth.authStateChanges(),
        builder: (context, snapshot) =>
            snapshot.hasData ? HomeScreen() : LoginScreen(),
      ),
    );
  }
}
