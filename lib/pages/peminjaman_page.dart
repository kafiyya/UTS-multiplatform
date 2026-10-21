import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';

class PeminjamanPage extends StatefulWidget {
  final Map<String, dynamic> alat;
  final String userRole;
  final String userName;

  PeminjamanPage({required this.alat, required this.userRole, required this.userName});

  @override
  _PeminjamanPageState createState() => _PeminjamanPageState();
}

class _PeminjamanPageState extends State<PeminjamanPage> {
  final TextEditingController _identitasController = TextEditingController();
  final TextEditingController _keperluanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.userRole == 'Peminjam') {
      _identitasController.text = widget.userName;
    }
  }

  Future<void> _prosesPeminjaman() async {
    if (_identitasController.text.isEmpty || _keperluanController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Identitas dan keperluan wajib diisi!')));
      return;
    }
    await DatabaseHelper.pinjamAlat(widget.alat['id'], _identitasController.text, _keperluanController.text);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Peminjaman berhasil dicatat!')));
    Navigator.pop(context);
  }

  Future<void> _prosesPengembalian() async {
    await DatabaseHelper.kembalikanAlat(widget.alat['id']);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Alat telah dikembalikan.')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isTersedia = widget.alat['status'] == 'Tersedia';
    bool isAdmin = widget.userRole == 'Pengurus (Admin)';

    return Scaffold(
      appBar: AppBar(title: Text('Detail & Peminjaman')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Nama Alat: ${widget.alat['nama_alat']}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text('Kategori: ${widget.alat['kategori']}', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 8),
                      Text('Status: ${widget.alat['status']}',
                          style: TextStyle(fontSize: 16, color: isTersedia ? Colors.green : Colors.red, fontWeight: FontWeight.bold)),

                      // Tampilkan info peminjam jika sedang dipinjam
                      if (!isTersedia && widget.alat['peminjam'] != null) ...[
                        Divider(),
                        Text('Dipinjam oleh: ${widget.alat['peminjam']}', style: TextStyle(fontSize: 15, color: Colors.blueGrey)),
                        Text('Keperluan: ${widget.alat['keperluan']}', style: TextStyle(fontSize: 15, color: Colors.blueGrey)),
                      ]
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Jika Peminjam dan tersedia
              if (!isAdmin && isTersedia) ...[
                Text('Form Pengajuan Peminjaman', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                TextField(
                  controller: _identitasController,
                  decoration: InputDecoration(labelText: 'Nama Lengkap / NIM', border: OutlineInputBorder()),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _keperluanController,
                  decoration: InputDecoration(labelText: 'Keperluan (contoh: Tugas Dokumentasi)', border: OutlineInputBorder()),
                  maxLines: 2,
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: EdgeInsets.symmetric(vertical: 12)),
                    onPressed: _prosesPeminjaman,
                    child: Text('Ajukan Peminjaman', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ]
              // Jika Admin dan sedang dipinjam (bisa mengembalikan)
              else if (isAdmin && !isTersedia) ...[
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.symmetric(vertical: 12)),
                    onPressed: _prosesPengembalian,
                    child: Text('Tandai Telah Dikembalikan', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}