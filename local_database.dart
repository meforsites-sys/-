import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  LocalDatabase._();
  static final LocalDatabase instance = LocalDatabase._();
  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    final dbPath = await getDatabasesPath();
    _db = await openDatabase(
      join(dbPath, 'ali_muiz_english.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE quiz_results(id INTEGER PRIMARY KEY AUTOINCREMENT, quiz_name TEXT NOT NULL, score INTEGER NOT NULL, total INTEGER NOT NULL, completed_at TEXT NOT NULL)");
      },
    );
    return _db!;
  }

  Future<void> saveQuizResult(String name, int score, int total) async {
    final db = await database;
    await db.insert('quiz_results', {
      'quiz_name': name,
      'score': score,
      'total': total,
      'completed_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Map<String, Object?>>> getResults() async {
    final db = await database;
    return db.query('quiz_results', orderBy: 'id DESC', limit: 20);
  }

  Future<Map<String, Object?>> getSummary() async {
    final db = await database;
    final rows = await db.rawQuery('SELECT COUNT(*) AS attempts, COALESCE(SUM(score),0) AS earned, COALESCE(SUM(total),0) AS possible FROM quiz_results');
    return rows.first;
  }
}
