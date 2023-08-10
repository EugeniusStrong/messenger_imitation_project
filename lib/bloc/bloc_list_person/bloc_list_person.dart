import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_imitation_project/bloc/bloc_list_person/state_list_person.dart';
import '../../database/database.dart';
import '../../database/generate_words.dart';
import '../../models/person_model.dart';
import '../../repository/person_api.dart';
import 'event_list_person.dart';

PersonApi _personApi = PersonApi();
DBProvider _dbProvider = DBProvider.db;
GenerateWords _generateWords = GenerateWords();

class ListPersonBloc extends Bloc<PersonListEvent, PersonListState> {
  ListPersonBloc() : super(PersonListInitialState()) {
    on<LoadListEvent>((event, emit) async {
      emit(PersonListInitialState());
      try {
        await Future.delayed(const Duration(seconds: 2));
        final persons = await _personApi.getPersonsList();
        List<String> randomMessagesList = _generateWords.getWords();
        for (String message in randomMessagesList) {
          try {
            await _dbProvider.insertOrUpdate(
              message: [message],
              receivingTime: DateTime.now(),
            );
            debugPrint('Message inserted successfully: $message');
          } catch (e) {
            debugPrint('Error inserting message: $message');
            debugPrint(e.toString());
          }
        }
        List<MessageModel> messagesObj = await _dbProvider.getMessage();

        for (Result result in persons) {
          MessageModel? foundMessage = messagesObj.firstWhere(
            (message) => message.id == result.phone,
            orElse: () =>
                MessageModel(messages: [], receivingTime: DateTime.now()),
          );

          debugPrint(
              'Person: ${result.name.first} ${result.name.last}, Message: ${foundMessage?.messages}');

          result.message = foundMessage;
        }

        emit(PersonListLoadedState(
          personList: persons,
        ));
      } catch (e) {
        emit(PersonListErrorState(message: e.toString()));
        debugPrint(e.toString());
      }
    });
  }
}
