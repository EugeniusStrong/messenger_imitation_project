import 'dart:math';
import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';
import 'package:messenger_imitation_project/models/message.dart';

class GenerateMessage {
  List<Message> getMessage() {
    final random = Random();
    final messageCount = random.nextInt(5) + 1;

    DateTime earliestDate = DateTime(2021, 1, 1);
    DateTime today = DateTime.now();
    int maxMilliseconds =
        today.millisecondsSinceEpoch - earliestDate.millisecondsSinceEpoch;

    final List<Message> randomMessagesList = [];

    for (int i = 0; i < messageCount; i++) {
      double randomMilliseconds = random.nextDouble() * maxMilliseconds;
      DateTime randomDateTime =
          earliestDate.add(Duration(milliseconds: randomMilliseconds.toInt()));

      final paragraphCount = random.nextInt(3) + 1;
      final wordCount = random.nextInt(9) + 7;
      final text = LoremIpsumGenerator.generate(
        paragraphs: paragraphCount,
        wordsPerParagraph: wordCount,
      );
      randomMessagesList.add(Message(
          messages: text, receivingTime: randomDateTime, isRead: false));
    }
    return randomMessagesList;
  }
}
