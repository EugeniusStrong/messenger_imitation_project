import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_imitation_project/pages/person_page.dart';
import 'bloc/bloc_list_person/bloc_list_person.dart';
import 'bloc/bloc_list_person/event_list_person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<ListPersonBloc>(
        create: (context) => ListPersonBloc()..add(LoadListEvent()),
        child: const PersonPage(),
      ),
    );
  }
}
