import 'package:dicoding_news_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createObject();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createObject();
    }

    return _databaseHelper;
  }

  static const String _tblFavorite = 'favorites';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restoapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavorite (
             id TEXT PRIMARY KEY,
             data TEXT
           )     
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  Future<void> insertFavorite(Restaurant resto) async {
    final db = await database;
    await db.insert(_tblFavorite, {"id": resto.id, "data": restoToJson(resto)});
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(_tblFavorite);

    return results.map((res) => restoFromJson(res["data"])).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
