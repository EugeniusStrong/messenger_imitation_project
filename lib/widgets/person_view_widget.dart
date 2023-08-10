import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_imitation_project/blocs/list_person_screen_bloc/list_person_screen_bloc.dart';
import 'package:messenger_imitation_project/blocs/list_person_screen_bloc/list_person_screen_state.dart';

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
                return Card(
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            image: NetworkImage(itemData.picture.large),
                            fit: BoxFit.cover),
                      ),
                    ),
                    title: Text('${itemData.name.first} ${itemData.name.last}'),
                    subtitle: Text(
                      state.personWithMessageList[index].messages.first
                              .messages ??
                          '',
                      overflow: TextOverflow.ellipsis,
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
