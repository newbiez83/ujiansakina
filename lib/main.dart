import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rsusakina/main_page.dart';
import 'package:rsusakina/screen/register.dart';
import 'package:rsusakina/screen/signin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

// ignore: must_be_immutable, use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  // const MyApp({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    _getUser();
    return MaterialApp(
      initialRoute: '/',
      title: 'RSU SAKINA',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => user == null ? SignInLogin() : MainPage(),
        '/login': (context) => SignInLogin(),
        '/home': (context) => MainPage(),
        '/register': (context) => Register(),
      },
      theme: ThemeData(brightness: Brightness.light, fontFamily: 'Lato'),
    );
  }
}
