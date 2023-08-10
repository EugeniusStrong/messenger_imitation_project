import 'package:equatable/equatable.dart';

abstract class PersonListEvent extends Equatable {
  @override
  bool? get stringify => true;
}

class LoadListEvent extends PersonListEvent {
  @override
  List<Object?> get props => const [];
}

class LoadMessageEvent extends PersonListEvent {
  final String id;
  final String message;
  final DateTime receivingTime;

  LoadMessageEvent(
      {required this.id, required this.message, required this.receivingTime});

  @override
  List<Object?> get props => [id, message, receivingTime];
}
