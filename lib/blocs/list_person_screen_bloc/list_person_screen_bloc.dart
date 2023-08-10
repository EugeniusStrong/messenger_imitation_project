import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_imitation_project/database/generate_words.dart';
import 'package:messenger_imitation_project/models/person_model.dart';
import 'package:messenger_imitation_project/models/person_with_messages.dart';
import 'package:messenger_imitation_project/repository/person_api.dart';
import 'list_person_screen_event.dart';
import 'list_person_screen_state.dart';

class ListPersonScreenBloc
    extends Bloc<ListPersonScreenEvent, ListPersonScreenState> {
  final PersonApi personApi;
  final GenerateMessage generateWords;
  ListPersonScreenBloc(this.personApi, this.generateWords)
      : super(ListPersonScreenLoadInProgress()) {
    on<ListPersonScreenOpened>((event, emit) async {
      emit(ListPersonScreenLoadInProgress());

      try {
        final persons = await personApi.getPersonsList();
        emit(ListPersonScreenLoadSuccess(
          personWithMessageList: _getPersonWithMessage(persons),
        ));
      } catch (e) {
        emit(ListPersonScreenError(message: e.toString()));
        debugPrint(e.toString());
      }
    });
  }
  List<PersonWithMessages> _getPersonWithMessage(List<Person> persons) {
    final result = <PersonWithMessages>[];
    for (final person in persons) {
      final messages = generateWords.getMessage();
      result.add(PersonWithMessages(person, messages));
    }
    return result;
  }
}
