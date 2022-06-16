import 'dart:io';
import 'package:fluttertraining/ApisModule/apis_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database!;
    // If database don't exists, create one
    _database = await initDB();
    return _database!;
  }

  Future<bool> databaseExists() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'training.db');
    return databaseFactory.databaseExists(path);
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'training.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Banners('
          'id INTEGER PRIMARY KEY,'
          'userId INTEGER,'
          'title Text'
          ')');
    });
  }

  // Banners model DB  on database
  createBanners(
    BannerModel bannerModel,
  ) async {
    final db = await database;

    final res = await db.insert('Banners', {
      'id': bannerModel.id,
      'title': bannerModel.title,
      'userId': bannerModel.id,
    });
    print(res.runtimeType);
    return res;
  }

  Future<List<BannerModel>> getBannersList() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Banners");

    return BannerModel.jsonTestApiModelList(res);
  }

  setBannersList(List<BannerModel> Banners) {
    for (int i = 0; i < Banners.length; i++) {
      createBanners(
        Banners[i],
      );
    }
  }

  deleteAllBanners() async {
    final db = await database;
    final res = await db.rawQuery("DELETE FROM Banners");
  }

  checkDataExistenceByLength(String table) async {
    final db = await database;
    int count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'))!;
    return count;
  }
}
