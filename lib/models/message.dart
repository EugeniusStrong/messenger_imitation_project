import 'package:uuid/uuid.dart';

class Message {
  String? id;
  String? messages;
  DateTime receivingTime;
  bool isOutgoing;

  Message(
      {this.id,
      required this.messages,
      required this.receivingTime,
      required this.isOutgoing}) {
    const uuid = Uuid();
    id = uuid.v4();
  }

  Message copyWith({
    String? id,
    String? messages,
    DateTime? receivingTime,
    bool? isOutgoing,
  }) {
    return Message(
      id: id ?? this.id,
      messages: messages ?? this.messages,
      receivingTime: receivingTime ?? this.receivingTime,
      isOutgoing: isOutgoing ?? this.isOutgoing,
    );
  }
}
