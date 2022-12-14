import 'package:chatappexample/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './screens/auth_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartCop',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: const Color.fromRGBO(28, 28, 36, 1),
        buttonTheme: ButtonTheme.of(context).copyWith(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        )
      ),
      home: AuthScreen(),
    );
  }
}
