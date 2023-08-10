import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';
import 'package:messenger_imitation_project/models/message.dart';

class GenerateMessage {
  List<Message> getMessage() {
    final random = Random();
    final messageCount = random.nextInt(5) + 1;
    final List<Message> randomMessagesList = [];

    for (int i = 0; i < messageCount; i++) {
      final paragraphCount = random.nextInt(3) + 1;
      final wordCount = random.nextInt(9) + 7;
      final text = LoremIpsumGenerator.generate(
        paragraphs: paragraphCount,
        wordsPerParagraph: wordCount,
      );
      debugPrint('Generated message $i: $text');
      randomMessagesList
          .add(Message(messages: text, receivingTime: DateTime.now()));
    }
    return randomMessagesList;
  }
}
