import 'package:equatable/equatable.dart';
import 'package:messenger_imitation_project/models/person_with_messages.dart';

abstract class ListPersonScreenEvent extends Equatable {
  const ListPersonScreenEvent();

  @override
  bool? get stringify => true;
}

class ListPersonScreenOpened extends ListPersonScreenEvent {
  @override
  List<Object?> get props => const [];
}

class ListPersonScreenChanged extends ListPersonScreenEvent {
  final PersonWithMessages personWithMessages;

  const ListPersonScreenChanged(this.personWithMessages);

  @override
  List<Object?> get props => [personWithMessages];
}

class ListPersonScreenAddedMessages extends ListPersonScreenEvent {
  @override
  List<Object?> get props => [];
}
