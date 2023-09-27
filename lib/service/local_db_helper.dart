import 'package:sqflite/sqflite.dart' as sql;

import '../common_config.dart';
import '../util/global.dart';

class DbHelper {
  late sql.Database _db;

  /// Opening database
  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, myDbName);
    _db = await sql.openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(sql.Database db, int version) async {
    await db.execute(
      "CREATE TABLE IF NOT EXISTS wishlist(id INTEGER PRIMARY KEY AUTOINCREMENT,movie_id INTEGER NOT NULL,"
      "title TEXT NOT NULL,poster TEXT NOT NULL,overview TEXT NOT NULL,release_date TEXT NOT NULL,rating REAL)",
    );
  }

  // INSERTING DATA
  Future<int> insertIntoWishListTable(Map<String, dynamic> data) async {
    int result = 0;
    result = await _db.insert("wishlist", data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return result;
  }

  // GETTING DATA
  Future<List<Map<String, dynamic>>> getWishListList() async {
    var res = await _db.query("wishlist");
    return res;
  }

  // GETTING LAST ADDED RECORD FOR UPDATING WishList ID
  Future getLastAddedRecord() async {
    var result =
        await _db.rawQuery("SELECT * FROM wishlist ORDER BY id DESC LIMIT 1");
    return result;
  }

  // DELETING A RECORD BY ID
  Future<int> deleteWishList(int id) async {
    return await _db.delete("wishlist", where: 'movie_id = ?', whereArgs: [id]);
  }

  // GETTING DETAILS FROM A SINGLE RECORD BY ID
  Future<List<Map<String, dynamic>>> getSingleWishList(int id) async {
    var res = await _db.query("wishlist", where: 'movie_id=?', whereArgs: [id]);
    return res;
  }
}
