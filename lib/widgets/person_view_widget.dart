import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_ext/list_ext.dart';
import 'package:messenger_imitation_project/blocs/list_person_screen_bloc/list_person_screen_bloc.dart';
import 'package:messenger_imitation_project/blocs/list_person_screen_bloc/list_person_screen_event.dart';
import 'package:messenger_imitation_project/blocs/list_person_screen_bloc/list_person_screen_state.dart';
import 'package:messenger_imitation_project/models/person_with_messages.dart';
import 'package:messenger_imitation_project/pages/chat_with_person.dart';

class PersonView extends StatefulWidget {
  const PersonView({super.key});

  @override
  State<PersonView> createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      final bloc = BlocProvider.of<ListPersonScreenBloc>(context);
      bloc.add(ListPersonScreenAddedMessages());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FakeMessengerApp',
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.indigo[400]),
        ),
      ),
      body: BlocBuilder<ListPersonScreenBloc, ListPersonScreenState>(
        builder: (context, state) {
          if (state is ListPersonScreenInitial ||
              state is ListPersonScreenLoadInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ListPersonScreenLoadSuccess) {
            return ListView.builder(
              itemCount: state.personWithMessageList.length,
              itemBuilder: (BuildContext context, int index) {
                final itemData = state.personWithMessageList[index].person;
                final itemCount = state.personWithMessageList[index].messages
                    .countWhere((e) => !e.isRead);
                return GestureDetector(
                  onTap: () async {
                    final res = await _openMessagePage(
                        context, state.personWithMessageList[index]);
                    if (res != null) {
                      BlocProvider.of<ListPersonScreenBloc>(context)
                          .add(ListPersonScreenChanged(res));
                    }
                  },
                  child: Card(
                    child: ListTile(
                      leading: Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(itemData.picture.large),
                              fit: BoxFit.cover),
                        ),
                      ),
                      title:
                          Text('${itemData.name.first} ${itemData.name.last}'),
                      subtitle: Text(
                        state.personWithMessageList[index].messages.first
                                .messages ??
                            '',
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            state.personWithMessageList[index].messages.first
                                .receivingTime
                                .toString()
                                .substring(11, 16),
                            style: const TextStyle(fontSize: 13),
                          ),
                          itemCount > 0
                              ? Container(
                                  height: 20,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[300]!),
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.indigo[400]),
                                  child: Center(
                                    child: Text(
                                      '$itemCount',
                                      style: const TextStyle(
                                          fontSize: 13, color: Colors.white),
                                    ),
                                  ),
                                )
                              : const SizedBox(
                                  height: 20,
                                  width: 30,
                                ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is ListPersonScreenError) {
            return Center(
              child: Text(state.message),
            );
          }
          return Container();
        },
      ),
    );
  }

  Future<PersonWithMessages?> _openMessagePage(
      BuildContext context, PersonWithMessages personWithMessages) {
    return Navigator.push<PersonWithMessages?>(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ChatWithPersonPage(personWithMessages: personWithMessages)));
  }
}
