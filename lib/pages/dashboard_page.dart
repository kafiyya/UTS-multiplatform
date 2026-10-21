import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';
import '../helpers/prefs_helper.dart';
import 'login_page.dart';
import 'tambah_alat_page.dart';
import 'peminjaman_page.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String userName = "Memuat...";
  String userRole = "Peminjam";
  late Future<List<Map<String, dynamic>>> listAlat;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    Map<String, String?> userData = await PrefsHelper.getUser();
    setState(() {
      userName = userData['name'] ?? "Pengguna";
      userRole = userData['role'] ?? "Peminjam";
      listAlat = DatabaseHelper.getSemuaAlat();
    });
  }

  Future<void> _logout() async {
    await PrefsHelper.clearUser();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventaris Alat'),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: _logout)],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Halo, $userName!\nMasuk sebagai: $userRole',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: listAlat,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
                if (!snapshot.hasData || snapshot.data!.isEmpty) return Center(child: Text('Belum ada data alat.'));

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var alat = snapshot.data![index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: Icon(Icons.camera_alt),
                        title: Text(alat['nama_alat']),
                        subtitle: Text(alat['status'] == 'Dipinjam'
                            ? '${alat['kategori']} - Dipinjam oleh ${alat['peminjam']}'
                            : '${alat['kategori']} - ${alat['status']}'),
                        trailing: Icon(alat['status'] == 'Tersedia' ? Icons.check_circle : Icons.cancel,
                            color: alat['status'] == 'Tersedia' ? Colors.green : Colors.red),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PeminjamanPage(alat: alat, userRole: userRole, userName: userName)),
                          ).then((_) => _loadData());
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      // Tombol tambah disembunyikan (null) jika perannya bukan Pengurus
      floatingActionButton: userRole == 'Pengurus (Admin)'
          ? FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => TambahAlatPage())).then((_) => _loadData());
        },
      )
          : null,
    );
  }
}