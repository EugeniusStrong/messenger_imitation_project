import 'package:uuid/uuid.dart';

class Message {
  String? id;
  String? messages;
  DateTime receivingTime;
  bool isRead;

  Message(
      {this.id,
      required this.messages,
      required this.receivingTime,
      required this.isRead}) {
    const uuid = Uuid();
    id = uuid.v4();
  }

  Message copyWith({
    String? id,
    String? messages,
    DateTime? receivingTime,
    bool? isRead,
  }) {
    return Message(
      id: id ?? this.id,
      messages: messages ?? this.messages,
      receivingTime: receivingTime ?? this.receivingTime,
      isRead: isRead ?? this.isRead,
    );
  }
}
