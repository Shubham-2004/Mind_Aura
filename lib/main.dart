import 'package:flutter/material.dart';
import 'package:mindaura/presentation/screens/homepage/homescreen.dart';
import 'package:mindaura/presentation/screens/homescreen_contains.dart';
import 'package:mindaura/presentation/screens/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://cqikrjbfvpshqmghjaiu.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNxaWtyamJmdnBzaHFtZ2hqYWl1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ2MjY1OTUsImV4cCI6MjA1MDIwMjU5NX0.3rorGlsMJJQiIW5C-wtEcRYR-VBggC_9IgD5IhfPK_0',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow.shade400),
        useMaterial3: true,
      ),
      home: HomeScreenContent(),
    );
  }
}
