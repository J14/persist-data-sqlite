import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Dog {
  int id;
  final String name;
  final int age;

  Dog({this.name, this.age});

  Dog.withId({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'name': this.name,
      'age': this.age,
    };
    if (this.id != null) {
      map['id'] = this.id;
    }

    return map;
  }
}

class DogDB {
  Future<Database> database;

  Future<void> open() async {
    this.database = openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE dogs ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT NOT NULL,"
          "age INTEGER NOT NULL"
          ")",
        );
      },
      version: 1
    );
  }

  Future<List<Dog>> listDog() async {
    Database db = await this.database;

    List<Map<String, dynamic>> maps = await db.query('dogs');

    return List.generate(maps.length, (i) {
      return Dog.withId(
        id: maps[i]['id'],
        name: maps[i]['name'],
        age: maps[i]['age']
      );
    });
  }

  Future<void> insertDog(Dog dog) async {
    Database db = await this.database;

    await db.insert(
      'dogs', dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<void> updateDog(Dog dog) async {
    Database db = await this.database;

    await db.update(
      'dogs',
      dog.toMap(),
      where: 'id = ?',
      whereArgs: [dog.id]
    );
  }

  Future<void> deleteDog(int id) async {
    Database db = await this.database;

    await db.delete(
      'dogs',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<void> close() async {
    Database db = await this.database;

    db.close();
  }
}
