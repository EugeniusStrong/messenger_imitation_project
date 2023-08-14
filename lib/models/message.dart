import 'package:uuid/uuid.dart';

class Message {
  String? id;
  String? messages;
  DateTime receivingTime;
  bool isOutgoing;
  bool isRead;

  Message(
      {this.id,
      required this.messages,
      required this.receivingTime,
      required this.isOutgoing,
      required this.isRead}) {
    const uuid = Uuid();
    id = uuid.v4();
  }

  Message copyWith({
    String? id,
    String? messages,
    DateTime? receivingTime,
    bool? isOutgoing,
    bool? isRead,
  }) {
    return Message(
      id: id ?? this.id,
      messages: messages ?? this.messages,
      receivingTime: receivingTime ?? this.receivingTime,
      isOutgoing: isOutgoing ?? this.isOutgoing,
      isRead: isRead ?? this.isRead,
    );
  }
}
