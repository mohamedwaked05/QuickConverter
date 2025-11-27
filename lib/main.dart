import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

// Main entry point of the Flutter app
// This function runs when the app starts
void main() {
  runApp(MyApp());
}

// Root widget of the application
// Stateless because it doesn't need to change after creation
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    // MaterialApp is the base widget for Material Design apps
    return MaterialApp(
      title: 'QuickConvert',  // App name shown in device app switcher
      theme: ThemeData(
        primarySwatch: Colors.blue,  // Default blue color theme
      ),
      home: HomeScreen(),  // First screen shown when app opens
      debugShowCheckedModeBanner: false,  // Removes the debug banner
    );
  }
}