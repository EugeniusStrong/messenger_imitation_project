import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';
// import 'database.dart';

// DBProvider _dbProvider = DBProvider.db;

class GenerateWords {
  List<String> getWords() {
    final random = Random();
    final messageCount = random.nextInt(5) + 1;
    final List<String> randomMessagesList = [];

    for (int i = 0; i < messageCount; i++) {
      final paragraphCount = random.nextInt(3) + 1;
      final wordCount = random.nextInt(9) + 7;

      final text = LoremIpsumGenerator.generate(
        paragraphs: paragraphCount,
        wordsPerParagraph: wordCount,
      );
      debugPrint('Generated message $i: $text');
      randomMessagesList.add(text);
    }
    return randomMessagesList;
  }

  // Future<void> insertRandomMessagesToDB() async {
  //   List<String> randomMessagesList = getWords();
  //
  //   for (String message in randomMessagesList) {
  //     try {
  //       await _dbProvider.insertOrUpdate(
  //         message: [message],
  //         receivingTime: DateTime.now(),
  //       );
  //       debugPrint('Message inserted successfully: $message');
  //     } catch (e) {
  //       debugPrint('Error inserting message: $message');
  //       debugPrint(e as String?);
  //     }
  //   }
  // }
}
