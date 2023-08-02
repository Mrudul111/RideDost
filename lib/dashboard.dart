// dashboard_screen.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the dashboard!'),
      ),
    );
  }

  Future<void> logoutUser(BuildContext context) async {
    // Remove user data from shared preferences on logout
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userToken');

    // Navigate back to LoginPage
    Navigator.pushReplacementNamed(context, '/');
  }
}
