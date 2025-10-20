import 'dart:async';
import 'dart:convert';

import 'package:dnn_dependencies/dnn_dependencies.dart';
import 'package:flutter/foundation.dart';

class SqfLiteHub {
  static Future<void> init() async {
    if (kIsWeb) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfiWeb;
    }
  }
}

Database? _database;

abstract class ILocalDb {
  Future<void> addData({String? key, dynamic data, bool? clearCurrentData});
  Future<List<dynamic>> readAllData();
  Future<List<dynamic>> readAllByKey({String? key});
  Future<dynamic> getById<T>({int? id});
  Future<void> deleteByKey({String? key});
  Future<void> clearDataBase();
}

class LocalDb implements ILocalDb {
  Future get database async {
    if (_database != null) return _database;
    _database = await _initializeDb('Dnn.db');
    return _database;
  }

  Future _initializeDb(String filePath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  FutureOr<void> _createDB(Database db, int version) async {
    db.execute('''
              CREATE TABLE LocalData (id INTEGER PRIMARY KEY,
              KEY VARCHAR(150) NOT NULL, 
              VALUE JSON NOT NULL)
              ''');
  }

  @override
  Future<void> clearDataBase() async {
    final db = await database;
    await db!.rawDelete('DELETE FROM LocalData ');
  }

  @override
  Future<void> deleteByKey({String? key}) async {
    final db = await database;

    await db!.rawDelete('DELETE FROM LocalData WHERE KEY = ?', [key]);
  }

  @override
  Future<void> addData(
      {String? key, dynamic data, bool? clearCurrentData}) async {
    final db = await database;

    if (clearCurrentData == true) {
      await deleteByKey(key: key);
    }

    if (data is List) {
      for (var element in data) {
        if (element is List) {
          for (var item in element) {
            final jsonData = jsonEncode(item);
            await db.insert('LocalData', {'KEY': key, 'VALUE': jsonData});
          }
        } else {
          final jsonData = jsonEncode(element);
          await db.insert('LocalData', {'KEY': key, 'VALUE': jsonData});
        }
      }
    } else {
      final jsonData = jsonEncode(data);
      await db.insert('LocalData', {'KEY': key, 'VALUE': jsonData});
    }
  }

  @override
  Future<List<dynamic>> readAllByKey({String? key}) async {
    final db = await database;

    final allData =
        await db!.rawQuery('SELECT * FROM LocalData WHERE KEY = ? ', [key]);
    return allData;
  }

  @override
  Future<List<dynamic>> readAllData() async {
    final db = await database;
    final allData = await db!.query('LocalData');
    return allData;
  }

  @override
  Future<dynamic> getById<T>({int? id}) async {
    final db = await database;
    final allData =
        await db!.rawQuery('SELECT * FROM LocalData WHERE id = ?', [id]);
    return allData;
  }
}

class LocalData {
  final int id;
  final String key;
  final dynamic value; // Atualizado para 'dynamic'

  LocalData({required this.id, required this.key, required this.value});

  // Método para criar uma instância da classe a partir de um Map
  factory LocalData.fromMap(Map<String, dynamic> map) {
    return LocalData(
      id: map['id'],
      key: map['KEY'],
      value: map[
          'VALUE'], // Como 'value' é 'dynamic', você pode diretamente atribuir o valor aqui
    );
  }

  // Método para converter a instância da classe para um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'KEY': key,
      'VALUE':
          value, // Como 'value' é 'dynamic', você pode diretamente atribuir o valor aqui
    };
  }
}
