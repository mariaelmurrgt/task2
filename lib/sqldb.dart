import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'userInfo.dart';

class SqlDb{

  static Database? _db;

  Future<Database>? get db async{
    if(_db == null){
      _db = await initialDb();
      return _db!;
    }else{
      return _db!;
    }
    // return await initialDb();
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'user.db');
    Database mydb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return mydb;
  }

  _onCreate(Database db, int version) async{
    await db.execute(
      'CREATE TABLE User(id STRING PRIMARY KEY, fname TEXT, lname TEXT, dateOfBirth DATETIME)'
    );
    print("Create Database");
  }


  Future<void> insertUser(UserInfo user) async {
    await _db!.insert('User', user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateUser(UserInfo user) async {
    await _db!.update('User', user.toMap(),
        where: 'id = ?', whereArgs: [user.id]);
  }

  Future<void> deleteUser(String userId) async {
    await _db!.delete('User', where: 'id = ?', whereArgs: [userId]);
  }

Future<List<UserInfo>> getUsers() async {
  final maps = await _db!.query('User');
  if (maps != null) {
    return List.generate(maps.length, (index) => UserInfo.fromMap(maps[index]));
  } else {
    return [];
  }
}
}