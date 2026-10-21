import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';

class TambahAlatPage extends StatefulWidget {
  @override
  _TambahAlatPageState createState() => _TambahAlatPageState();
}

class _TambahAlatPageState extends State<TambahAlatPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _kategoriController = TextEditingController();

  Future<void> _simpanAlat() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> alatBaru = {
        'nama_alat': _namaController.text,
        'kategori': _kategoriController.text,
        'status': 'Tersedia',
      };
      await DatabaseHelper.insertAlat(alatBaru);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Alat disimpan!')));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Alat')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(labelText: 'Nama Alat (contoh: Sony A7III)'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _kategoriController,
                decoration: InputDecoration(labelText: 'Kategori (contoh: Kamera / Lensa)'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _simpanAlat, child: Text('Simpan Alat'))
            ],
          ),
        ),
      ),
    );
  }
}