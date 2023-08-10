import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../database/database.dart';
import '../models/person_model.dart';

DBProvider _dbProvider = DBProvider.db;

class PersonApi {
  Future<List<Result>> getPersonsList() async {
    String url = 'https://randomuser.me/api/?results=7';
    final response = await http.get(Uri.parse(url));
    debugPrint('response: ${response.body}');
    if (response.statusCode == 200) {
      final personModel = PersonModel.fromJson(response.body);
      final List<Result> results = personModel.results;

      List<MessageModel> messagesObj = await _dbProvider.getNotes();

      for (Result result in results) {
        MessageModel? foundMessage = messagesObj.firstWhere(
          (message) => message.id == result.phone,
        );

        result.message = foundMessage;
      }

      return results;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
