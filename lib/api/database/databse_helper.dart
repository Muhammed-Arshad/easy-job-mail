import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../model/file_model.dart';
import '../../model/mail_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('mails.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE mails (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        subject TEXT NOT NULL,
        body TEXT NOT NULL,
        attachment TEXT
      )
    ''');
  }

  // Fetch all mails
  Future<List<MailModel>> fetchAllMails() async {
    final db = await database;
    final result = await db.query('mails');
    return result.map((json) => MailModel.fromMap(json)).toList();
  }

  // Insert a mail
  Future<int> insertMail(MailModel mail) async {
    final db = await database;
    return await db.insert('mails', mail.toMap());
  }

  // Delete a mail
  Future<int> deleteMail(int id) async {
    final db = await database;
    return await db.delete('mails', where: 'id = ?', whereArgs: [id]);
  }
}

// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
// import 'file_model.dart';

class FileStorage {
  static const String _fileKey = 'file_list';

  // Save list of FileModel to SharedPreferences
  static Future<void> saveFiles(List<FileModel> files) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> fileJsonList =
    files.map((file) => jsonEncode(file.toJson())).toList();
    await prefs.setStringList(_fileKey, fileJsonList);
  }

  // Load list of FileModel from SharedPreferences
  static Future<List<FileModel>> loadFiles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? fileJsonList = prefs.getStringList(_fileKey);

    if (fileJsonList == null) return [];

    return fileJsonList
        .map((fileJson) => FileModel.fromJson(jsonDecode(fileJson)))
        .toList();
  }
}

