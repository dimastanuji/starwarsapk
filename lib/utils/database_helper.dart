import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

import 'package:starwarsapk/model/local.dart';

class DatabaseHelper {

	static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
	static Database _database;                // Singleton Database

	String localTable = 'local_table';
	String colId = 'id';
	String colNama = 'nama';
	String colUrl = 'url';
	String colPriority = 'priority';
  String colDate = 'date';

	DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

	factory DatabaseHelper() {

		if (_databaseHelper == null) {
			_databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
		}
		return _databaseHelper;
	}

	Future<Database> get database async {

		if (_database == null) {
			_database = await initializeDatabase();
		}
		return _database;
	}

	Future<Database> initializeDatabase() async {
		// Get the directory path for both Android and iOS to store database.
		Directory directory = await getApplicationDocumentsDirectory();
		String path = directory.path + 'locals.db';

		// Open/create the database at a given path
		var localsDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
		return localsDatabase;
	}

	void _createDb(Database db, int newVersion) async {

		await db.execute('CREATE TABLE $localTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNama TEXT, '
				'$colUrl TEXT, $colPriority INTEGER,  $colDate TEXT)');
	}

	// Fetch Operation: Get all note objects from database
	Future<List<Map<String, dynamic>>> getLocalMapList() async {
		Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
		var result = await db.query(localTable, orderBy: '$colPriority ASC');
		return result;
	}

	// Insert Operation: Insert a Note object to database
	Future<int> insertLocal(Local local) async {
		Database db = await this.database;
		var result = await db.insert(localTable, local.toMap());
		return result;
	}

	// Update Operation: Update a Note object and save it to database
	Future<int> updateLocal(Local local) async {
		var db = await this.database;
		var result = await db.update(localTable, local.toMap(), where: '$colId = ?', whereArgs: [local.id]);
		return result;
	}

	// Delete Operation: Delete a Note object from database
	Future<int> deleteLocal(int id) async {
		var db = await this.database;
		int result = await db.rawDelete('DELETE FROM $localTable WHERE $colId = $id');
		return result;
	}

	// Get number of Note objects in database
	Future<int> getCount() async {
		Database db = await this.database;
		List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $localTable');
		int result = Sqflite.firstIntValue(x);
		return result;
	}

	// Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
	Future<List<Local>> getLocalList() async {

		var localMapList = await getLocalMapList(); // Get 'Map List' from database
		int count = localMapList.length;         // Count the number of map entries in db table

		List<Local> localList = List<Local>();
		// For loop to create a 'Note List' from a 'Map List'
		for (int i = 0; i < count; i++) {
			localList.add(Local.fromMapObject(localMapList[i]));
		}

		return localList;
	}

}







