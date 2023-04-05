import 'package:flutter/material.dart';
import './screens/HomeScreen.dart';
import './screens/gridScreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: "ThoughtBox",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      routes: {
        "/":(_) => HomeScreen(),
      GridScreen.routeName:(_)=>const GridScreen(),
      },
    );
  }
}
