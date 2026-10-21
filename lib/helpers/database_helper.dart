import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String tableName = 'alat';

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('inventaris_ukm_foto.db');
    return _database!;
  }

  static Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1, // Jika error kolom tidak ditemukan, uninstall aplikasi dari HP lalu jalankan ulang
      onCreate: _createDB,
    );
  }

  static Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama_alat TEXT NOT NULL,
        kategori TEXT NOT NULL,
        status TEXT NOT NULL,
        peminjam TEXT,
        keperluan TEXT
      )
    ''');
  }

  static Future<int> insertAlat(Map<String, dynamic> alat) async {
    final db = await database;
    return await db.insert(tableName, alat);
  }

  static Future<List<Map<String, dynamic>>> getSemuaAlat() async {
    final db = await database;
    return await db.query(tableName, orderBy: 'id DESC');
  }

  // Fungsi baru khusus untuk mencatat peminjam
  static Future<int> pinjamAlat(int id, String namaPeminjam, String keperluan) async {
    final db = await database;
    return await db.update(
      tableName,
      {'status': 'Dipinjam', 'peminjam': namaPeminjam, 'keperluan': keperluan},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Fungsi baru khusus untuk mengembalikan alat (menghapus nama peminjam)
  static Future<int> kembalikanAlat(int id) async {
    final db = await database;
    return await db.update(
      tableName,
      {'status': 'Tersedia', 'peminjam': null, 'keperluan': null},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  // Fungsi baru khusus untuk menghapus data alat dari database
  static Future<int> hapusAlat(int id) async {
    final db = await database;
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}