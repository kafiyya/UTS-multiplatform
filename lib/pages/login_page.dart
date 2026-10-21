import 'package:flutter/material.dart';
import '../helpers/prefs_helper.dart';
import 'dashboard_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'Peminjam'; // Default awal

  Future<void> _login() async {
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nama tidak boleh kosong!')));
      return;
    }

    // Validasi sandi jika memilih Pengurus
    if (_selectedRole == 'Pengurus (Admin)') {
      if (_passwordController.text != 'admin123') { // Kata sandi hardcoded
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Kata sandi salah!')));
        return;
      }
    }

    // Simpan ke Shared Preferences
    await PrefsHelper.saveUser(_nameController.text, _selectedRole);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sistem Login UKM')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Image.asset('assets/logo_ukm.png', width: 120, height: 120,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.camera_alt, size: 100, color: Colors.blue),
              ),
              SizedBox(height: 20),
              Text('Inventaris UKM JC UIN Malang', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),

              // Pilihan Peran
              DropdownButtonFormField<String>(
                value: _selectedRole,
                items: ['Peminjam', 'Pengurus (Admin)'].map((String role) {
                  return DropdownMenuItem(value: role, child: Text(role));
                }).toList(),
                onChanged: (newValue) {
                  setState(() { _selectedRole = newValue!; });
                },
                decoration: InputDecoration(labelText: 'Masuk Sebagai', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16),

              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nama Lengkap', border: OutlineInputBorder()),
              ),
              SizedBox(height: 16),

              // Kolom sandi hanya muncul jika memilih Pengurus
              if (_selectedRole == 'Pengurus (Admin)') ...[
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Kata Sandi', border: OutlineInputBorder()),
                ),
                SizedBox(height: 16),
              ],

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(onPressed: _login, child: Text('Masuk Aplikasi')),
              )
            ],
          ),
        ),
      ),
    );
  }
}