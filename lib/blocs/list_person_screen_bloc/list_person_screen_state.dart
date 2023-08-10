import 'package:equatable/equatable.dart';
import 'package:messenger_imitation_project/models/person_with_messages.dart';

abstract class ListPersonScreenState extends Equatable {
  const ListPersonScreenState();

  @override
  List<Object?> get props => [];
}

class ListPersonScreenInitial extends ListPersonScreenState {
  @override
  List<Object?> get props => [];
}

class ListPersonScreenLoadInProgress extends ListPersonScreenState {
  @override
  List<Object?> get props => [];
}

class ListPersonScreenLoadSuccess extends ListPersonScreenState {
  final List<PersonWithMessages> personWithMessageList;

  const ListPersonScreenLoadSuccess({
    required this.personWithMessageList,
  });

  @override
  List<Object?> get props => [personWithMessageList];
}

class ListPersonScreenError extends ListPersonScreenState {
  final String message;

  const ListPersonScreenError({required this.message});

  @override
  List<Object?> get props => [message];
}
