import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/person_model.dart';

class PersonApi {
  Future<List<Person>> getPersonsList() async {
    String url = 'https://randomuser.me/api/?results=8';
    final response = await http.get(Uri.parse(url));
    debugPrint('response: ${response.body}');
    if (response.statusCode == 200) {
      final personModel = Result.fromJson(response.body);
      final List<Person> results = personModel.persons;

      return results;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
