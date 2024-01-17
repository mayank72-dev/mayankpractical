import 'package:mayankptactical/src/Model/data_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io'as io;

class DBHelper{
  static Database?_db;

  Future<Database?> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDatabase();
    return null;
  }
  initDatabase()async{
    io.Directory  documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,'Todo.db');
    var db= await openDatabase(path,version: 1, onCreate: _createDatabase);
    return db;
  }
  _createDatabase(Database db, int version )async{
    await db.execute(
      "CREATE TABLE mytodo(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, dueDate TEXT NOT NULL, categories TEXT NOT NULL,)",
    );
  }
  Future<DataModel>  insert(DataModel dataModel)async{
    var dbClient = await db;
    await dbClient?.insert('mytodo', dataModel.toMap());
    return dataModel;
  }

Future<List<DataModel>> getDataList()async{
    await db;
    final List<Map<String, Object?>>  QueryResult = await _db!.rawQuery('SELECT * FROM mytodo');
    return QueryResult.map((e) => DataModel.fromMap(e)).toList();
}

Future<int>delete(int id)async{
    var dbClient = await db;
    return await dbClient!.delete('mytodo', where: 'id = ?',whereArgs: [id]);
}

Future<int> update(DataModel dataModel)async{
    var dbClinet  = await db;
    return await dbClinet!.update('mytodo', dataModel.toMap(),where: 'id = ?',whereArgs: [dataModel.id] );
}




}
