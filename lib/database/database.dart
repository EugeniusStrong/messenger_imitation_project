import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../models/person_model.dart';
import 'dart:convert';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database? _database;

  static const messageTable = 'MessageForApp';
  static const columnId = 'id';
  static const columnMessage = 'message';
  static const columnReceivingTime = 'receivingTime';

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDB();
    return _database;
  }

  Future<Database?> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}/MessageForApp.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  void _createDb(Database db, int version) async {
    await db.execute('CREATE TABLE $messageTable'
        '($columnId TEXT PRIMARY KEY,'
        ' $columnMessage TEXT,'
        ' $columnReceivingTime TEXT)');
  }

  String encodeStringList(List<String> list) {
    return jsonEncode(list);
  }

  List<String> decodeStringList(String json) {
    List<dynamic> decoded = jsonDecode(json);
    return decoded.cast<String>();
  }

  Future<List<MessageModel>> getMessage() async {
    Database? db = await database;
    final List<Map<String, dynamic>> messageMapList =
        await db!.query(messageTable);
    final List<MessageModel> messageList = [];
    for (var messageMap in messageMapList) {
      messageList.add(MessageModel(
        id: messageMap[columnId],
        messages: decodeStringList(messageMap[columnMessage]),
        receivingTime: DateTime.parse(messageMap[columnReceivingTime]),
      ));
    }
    return messageList;
  }

  Future<int> deleteMessage(String id) async {
    Database? db = await database;
    return await db!.delete(
      messageTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<void> insertOrUpdate(
      {String? id,
      required List<String> message,
      required DateTime receivingTime}) async {
    final model = MessageModel(
      id: id,
      messages: message,
      receivingTime: receivingTime,
    );
    Database? db = await database;
    await db!.insert(
        messageTable,
        {
          columnId: model.id,
          columnMessage: encodeStringList(model.messages),
          columnReceivingTime: model.receivingTime.toIso8601String(),
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
