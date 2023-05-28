import 'package:ljubljana/app/database/database_helper.dart';
import 'package:ljubljana/app/models/user_model.dart';
import 'package:ljubljana/app/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

class DBUserRepository {
  DBUserRepository() {
    databaseHelper = DatabaseHelper();
  }

  DatabaseHelper? databaseHelper;

  Future<int> insertUser(User model) async {
    int result = 0;
    final Database db = await databaseHelper!.database;
    final int? count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM ${Constants.userTable} WHERE Email = ?', <String>[model.email]));
    if (count == 0) {
      result = await db.insert(Constants.userTable, model.dbToJson());
    } else {
      result = await db.update(Constants.userTable, model.dbToJson(), where: 'Email = ?', whereArgs: <String>[model.email]);
    }
    return result;
  }

  Future<User> fetchUserDB() async {
    final Database db = await databaseHelper!.database;
    final List<Map<String, dynamic>> result = await db.query(Constants.userTable);
    return result.isNotEmpty ? User.dbFromJson(result[0]) : User();
  }

  Future<int> deleteUserTable() async {
    int result = 0;
    final Database db = await databaseHelper!.database;
    result = await db.delete(Constants.userTable);
    return result;
  }
}
