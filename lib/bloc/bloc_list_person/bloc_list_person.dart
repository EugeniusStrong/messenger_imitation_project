import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_imitation_project/bloc/bloc_list_person/state_list_person.dart';
import '../../repository/person_api.dart';
import 'event_list_person.dart';

PersonApi _personApi = PersonApi();


class ListPersonBloc extends Bloc<PersonListEvent, PersonListState> {
  ListPersonBloc() : super(PersonListInitialState()) {
    on<LoadListEvent>((event, emit) async {
      emit(PersonListInitialState());
      try {
        final persons = await _personApi.getPersonsList();

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
