import 'package:equatable/equatable.dart';

abstract class ListPersonScreenEvent extends Equatable {
  @override
  bool? get stringify => true;
}

class ListPersonScreenOpened extends ListPersonScreenEvent {
  @override
  List<Object?> get props => const [];
}
