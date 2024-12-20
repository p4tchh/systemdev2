import 'package:flutter/material.dart';
import 'src/screens/auth/login_screen.dart'; // Import LoginScreen
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://qaqloaalyvtfdntwzxhg.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFhcWxvYWFseXZ0ZmRudHd6eGhnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ2NzYxNDQsImV4cCI6MjA1MDI1MjE0NH0.cEdxFjw2QqrhV2QlgzBuW69eTy9mycQIVNWDikEwBn0',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Set LoginScreen as the initial screen
    );
  }
}
