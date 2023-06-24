import 'package:flutter/material.dart';
import 'package:usermanagement/screens/root_screen.dart';

class App extends StatelessWidget{
  const App({super.key});
  @override
Widget build(BuildContext context){
    return MaterialApp(
      title: 'App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        fontFamily: 'JetBrainsMono'
      ),

      home: const RootScreen(),
    );
  }
}