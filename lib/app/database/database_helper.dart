import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:ljubljana/app/utils/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    if (_databaseHelper != null) {
      return _databaseHelper!;
    }
    return DatabaseHelper();
  }

  DatabaseHelper._createInstance();

  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = p.join(directory.path, Constants.dbName);

    final Database database = await openDatabase(
      path,
      version: _scripts.length,
      onCreate: (Database db, int version) async {
        debugPrint('Database created!');
        for (int i = 1; i <= _scripts.length; i++) {
          for (int j = 0; j <= _scripts.length; j++) {
            await db.execute(_scripts[i]![j]);
          }
        }
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        debugPrint('Database upgraded');
        for (int i = oldVersion + 1; i <= newVersion; i++) {
          for (int j = 0; j <= _scripts.length; i++) {
            await db.execute(_scripts[i]![j]);
          }
        }
      },
      onOpen: (Database db) async {
        debugPrint('Database opened: ${await db.getVersion()}.v');
      },
    );

    return database;
  }

  Future<void> deleteDb(Database? db) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String path = p.join(directory.path, Constants.dbName);
    db = null;
    _database = null;
    await deleteDatabase(path);
  }
}

// version needs to be sequential and start with 1
const Map<int, List<String>> _scripts = {
  1: <String>[
    ''' 
      CREATE TABLE IF NOT EXISTS ${Constants.distanceTable} (
              Id INTEGER PRIMARY KEY,
              Email TEXT,
              CreatedDate TEXT,
              Distance INTEGER
      )   
  ''',
    ''' 
      CREATE TABLE IF NOT EXISTS ${Constants.topDistanceTable} (
              Id INTEGER PRIMARY KEY,
              Email TEXT,
              CreatedDate TEXT,
              Distance INTEGER
      )   
  '''
  ],
  2: <String>[
    ''' 
       CREATE TABLE IF NOT EXISTS ${Constants.userTable} (
              Email TEXT PRIMARY KEY,
              FirstName TEXT,
              LastName TEXT,
              Municipality TEXT,
              Info TEXT,
              Gender INTEGER,
              Age INTEGER,
              Weight INTEGER,
              Height INTEGER,
              IsOnboardingFinished INTEGER
       )
    '''
  ]
};
