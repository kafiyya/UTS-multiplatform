import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/dashboard_page.dart';
import 'helpers/prefs_helper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventaris UKM Foto',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<Map<String, String?>>(
        future: PrefsHelper.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          // Cek apakah data nama ada (berarti sudah pernah login)
          if (snapshot.hasData && snapshot.data!['name'] != null) {
            return DashboardPage();
          }
          return LoginPage();
        },
      ),
    );
  }
}