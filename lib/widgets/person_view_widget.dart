import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc_list_person/bloc_list_person.dart';
import '../bloc/bloc_list_person/state_list_person.dart';

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
      body: BlocBuilder<ListPersonBloc, PersonListState>(
        builder: (context, state) {
          if (state is PersonListInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PersonListLoadedState) {
            return ListView.builder(
              itemCount: state.personList.length,
              itemBuilder: (BuildContext context, int index) {
                final itemData = state.personList[index];
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
                    //subtitle: Text(itemData.message.messages[0]),
                  ),
                );
              },
            );
          } else if (state is PersonListErrorState) {
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
