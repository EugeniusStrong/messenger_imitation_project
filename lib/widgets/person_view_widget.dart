import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_imitation_project/blocs/list_person_screen_bloc/list_person_screen_bloc.dart';
import 'package:messenger_imitation_project/blocs/list_person_screen_bloc/list_person_screen_state.dart';
import 'package:messenger_imitation_project/pages/message_page.dart';

class PersonView extends StatefulWidget {
  const PersonView({super.key});

  @override
  State<PersonView> createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {},
        ),
        centerTitle: true,
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
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MessagePage(
                                  personWithMessages:
                                      state.personWithMessageList[index],
                                )));
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
                            state.personWithMessageList[index].messages.last
                                .receivingTime
                                .toString()
                                .substring(11, 16),
                            style: const TextStyle(fontSize: 13),
                          ),
                          Container(
                            height: 20,
                            width: 30,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[300]!),
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white70),
                            child: Center(
                              child: Text(
                                state.personWithMessageList[index].messages
                                    .length
                                    .toString(),
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
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
}
