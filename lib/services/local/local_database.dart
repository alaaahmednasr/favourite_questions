import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/models/questions_model.dart';

class QuestionsDatabase {
  QuestionsDatabase._();

  static final QuestionsDatabase _instance = QuestionsDatabase._();

  factory QuestionsDatabase() => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String appPath = await getDatabasesPath();
    String dbPath = join(appPath, 'questions.db');
    return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    Batch batch = db.batch();

    batch.execute(
      '''
      CREATE TABLE Questions(
         id TEXT,
         question TEXT,
         isFavourite TEXT
      )
      ''',
    );

    await batch.commit();
  }

  Future<List<QuestionsModel>> readAllRows() async {
    final db = await _instance.database;

    List<Map<String, dynamic>> response = await db.query(
      'Questions',
    );

    log('response: ${response.toString()}',
        name: 'All Questions ======> read all questions ======');

    return response.map((e) => QuestionsModel.fromJson(e)).toList();
  }

  Future<List<QuestionsModel>> readAllFavouriteQuestions() async {
    final db = await _instance.database;

    List<Map<String, dynamic>> response = await db.query(
      'Questions',
      where: 'isFavourite = ?',
      whereArgs: ["true"],
    );

    log('response: ${response.toString()}',
        name:
            'All Favourite Questions ======> read all favourite questions ======');

    return response.map((e) => QuestionsModel.fromJson(e)).toList();
  }

  Future insertRows(List<QuestionsModel> questionsList) async {
    final db = await _instance.database;

    int response = 0;

    for (var question in questionsList) {
      response = await db.insert('Questions', question.toJson());
    }

    log('response: ${response.toString()}',
        name: 'All Questions ======> insert all questions ======');

    return response;
  }

  Future updateRow(QuestionsModel question) async {
    final db = await _instance.database;

    int response = await db.update(
      'Questions',
      question.toJson(),
      where: 'id = ?',
      whereArgs: [question.id],
    );

    log('response: ${response.toString()}',
        name: 'All Questions ======> update question ======');

    return response;
  }
}
