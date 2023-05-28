import 'package:ljubljana/app/database/database_helper.dart';
import 'package:ljubljana/app/models/distance_model.dart';
import 'package:ljubljana/app/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

class DBDistanceRepository {
  DBDistanceRepository() {
    databaseHelper = DatabaseHelper();
  }

  DatabaseHelper? databaseHelper;

  Future<int> insertDistanceModel(DistanceModel model) async {
    int result = 0;
    final Database db = await databaseHelper!.database;
    final int? count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM ${Constants.distanceTable} WHERE id = ?', <int>[model.id]));
    if (count == 0) {
      result = await db.insert(Constants.distanceTable, model.dbToJson());
    } else {
      result = await db.update(Constants.distanceTable, model.dbToJson(), where: 'id = ?', whereArgs: <int>[model.id]);
    }
    return result;
  }

  Future<int> insertTopDistance(DistanceModel model) async {
    int result = 0;
    final Database db = await databaseHelper!.database;
    final int? count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM ${Constants.topDistanceTable} WHERE id = ?', <int>[model.id]));
    if (count == 0) {
      result = await db.insert(Constants.topDistanceTable, model.dbToJson());
    } else {
      result = await db.update(Constants.topDistanceTable, model.dbToJson(), where: 'id = ?', whereArgs: <int>[model.id]);
    }
    return result;
  }

  Future<List<DistanceModel>> fetchTopDistances() async {
    final List<DistanceModel> listDistances = <DistanceModel>[];
    final Database db = await databaseHelper!.database;
    final List<Map<String, dynamic>> result = await db.query(Constants.topDistanceTable);
    result.map((Map<String, dynamic> e) => listDistances.add(DistanceModel.dbFromJson(e))).toList();
    return listDistances;
  }

  Future<List<DistanceModel>> fetchDistances() async {
    final List<DistanceModel> listDistances = <DistanceModel>[];
    final Database db = await databaseHelper!.database;
    final List<Map<String, dynamic>> result = await db.query(Constants.distanceTable);
    result.map((Map<String, dynamic> e) => listDistances.add(DistanceModel.dbFromJson(e))).toList();
    return listDistances;
  }

  Future<int> deleteDistanceTable() async {
    int result = 0;
    final Database db = await databaseHelper!.database;
    result = await db.delete(Constants.distanceTable);
    return result;
  }

  Future<int> deleteTopDistanceTable() async {
    int result = 0;
    final Database db = await databaseHelper!.database;
    result = await db.delete(Constants.topDistanceTable);
    return result;
  }
}
