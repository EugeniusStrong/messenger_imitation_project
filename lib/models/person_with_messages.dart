import 'package:messenger_imitation_project/models/message.dart';
import 'package:messenger_imitation_project/models/person_model.dart';

class PersonWithMessages {
  final Person person;
  final List<Message> messages;

  PersonWithMessages(this.person, this.messages);
}
