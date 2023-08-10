import 'package:equatable/equatable.dart';
import '../../models/person_model.dart';

abstract class PersonListState extends Equatable {
  const PersonListState();

  @override
  List<Object?> get props => [];
}

class PersonListInitialState extends PersonListState {
  @override
  List<Object?> get props => [];
}

// class PersonListMessageLoading extends PersonListState {
//   final List<List<MessageContent>> oldMessageList;
//   final bool isFirstFetch;
//
//   const PersonListMessageLoading(this.oldMessageList,
//       {this.isFirstFetch = false});
//
//   @override
//   List<Object?> get props => [oldMessageList];
// }

class PersonListLoadedState extends PersonListState {
  final List<Result> personList;

  const PersonListLoadedState({
    required this.personList,
  });

  @override
  List<Object?> get props => [personList];
}

class PersonListErrorState extends PersonListState {
  final String message;

  const PersonListErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
