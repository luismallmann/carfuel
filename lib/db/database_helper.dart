import 'dart:async';
import 'dart:io' as io;

import 'package:carfuel/models/abastecer.dart';
import 'package:carfuel/models/carro.dart';
import 'package:carfuel/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseHelper {
  final String databaseName = "carfuel.db";
  final int databaseVersion = 1;

  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory docDir = await getApplicationDocumentsDirectory();
    debugPrint(docDir.path);
    String path = join(docDir.path, databaseName);
    var theDb =
    await openDatabase(path, version: databaseVersion, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE user (idUsuario INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, password TEXT);");
    await db.execute(
        "CREATE TABLE carro (idCarro INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, modelo TEXT, fabricante TEXT, placa TEXT, ano int, kmInicial double, FK_idUsuario int NOT NULL);");

    await db.execute(
        "CREATE TABLE abastecer (idAbastecimento INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, valor double, quantidade double, kmAtual double, dataAbastecimento TEXT, FK_idCarro int);");
  }

  //usuario

  Future<int> saveUser(User u) async {
    var dbClient = await db;
    int res = await dbClient.insert("user", u.toMap());
    debugPrint("$res");
    return res;
  }

  Future<List<User>> getUsers() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM user ORDER BY name');
    List<User> users = new List();
    for (int i = 0; i < list.length; i++) {
      var u = new User(list[i]["idUsuario"], list[i]["name"], list[i]["email"],
          list[i]["password"]);
      users.add(u);
    }

    print(users.length);

    return users;
  }

  Future<User> validateLogin(String email, String password) async {
    var dbClient = await db;
    User user;
    List<Map> list = await dbClient.rawQuery(
        'SELECT * FROM user WHERE email = ? and password = ?',
        [email, password]);
    if (list != null && list.length > 0)
      user = User(list[0]["idUsuario"], list[0]["name"], list[0]["email"],
          list[0]["password"]);

    debugPrint(list[0]["email"]);
    return user;
  }

  Future<int> deleteUser(User u) async {
    var dbClient = await db;

    int res = await dbClient.rawDelete('DELETE FROM user WHERE idUsuario = ?', [u.idUsuario]);
    return res;
  }

  Future<bool> updateUser(User u) async {
    var dbClient = await db;

    int res = await dbClient
        .update("user", u.toMap(), where: "idUsuario = ?", whereArgs: <int>[u.idUsuario]);

    return res > 0 ? true : false;
  }


  //carro
  Future<int> saveCarro(Carro c) async {
    var dbClient = await db;
    int res = await dbClient.insert("carro", c.toMap());
    debugPrint("$res");
    print('ok salvo');
    return res;
  }

  Future<List<Carro>> listarCarros() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM carro ORDER BY modelo');
    List<Carro> carros = new List();
    for (int i = 0; i < list.length; i++) {
      var c = new Carro(list[i]["idCarro"], list[i]["modelo"], list[i]["fabricante"],
          list[i]["placa"], list[i]["ano"], list[i]["kmInicial"], list[i]["FK_idUsuario"]);
      carros.add(c);
    }
    return carros;
  }

  Future<int> deleteCarro(Carro c) async {
    var dbClient = await db;

    int res = await dbClient.rawDelete('DELETE FROM carro WHERE idCarro = ?', [c.idCarro]);
    return res;
  }

  Future<bool> updateCarro(Carro c) async {
    var dbClient = await db;

    int res = await dbClient
        .update("carro", c.toMap(), where: "idCarro = ?", whereArgs: <int>[c.idCarro]);

    return res > 0 ? true : false;
  }


  //abastecemimento
  Future<int> saveAbastecimento(Abastecer a) async {
    var dbClient = await db;
    int res = await dbClient.insert("abastecer", a.toMap());
    debugPrint("$res");
    return res;
  }

  Future<List<Abastecer>> listarAbastecimento() async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM abastecimento ORDER BY idAbastecimento');
    List<Abastecer> abastecimento = new List();
    for (int i = 0; i < list.length; i++) {
      var a = new Abastecer(list[i]["idAbastecimento"], list[i]["valor"], list[i]["quantidade"],
          list[i]["kmAtual"],list[i]['dataAbastecimento'], list[i]["FK_idCarro"]);
      abastecimento.add(a);
    }
    print(abastecimento.length);

    return abastecimento;
  }

  Future<int> deleteAbastecimento(Abastecer a) async {
    var dbClient = await db;

    int res = await dbClient.rawDelete('DELETE FROM abastecer WHERE idAbastecimento = ?', [a.idAbastecimento]);
    return res;
  }

  Future<bool> updateAbastecimento(Abastecer a) async {
    var dbClient = await db;

    int res = await dbClient
        .update("abastecer", a.toMap(), where: "idAbastecimento = ?", whereArgs: <int>[a.idAbastecimento]);

    return res > 0 ? true : false;
  }



}
