import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messenger_imitation_project/blocs/list_person_screen_bloc/list_person_screen_bloc.dart';
import 'package:messenger_imitation_project/blocs/list_person_screen_bloc/list_person_screen_event.dart';
import 'package:messenger_imitation_project/database/generate_words.dart';
import 'package:messenger_imitation_project/pages/person_page.dart';
import 'package:messenger_imitation_project/repository/person_api.dart';

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
      home: BlocProvider<ListPersonScreenBloc>(
        create: (context) =>
            ListPersonScreenBloc(PersonApi(), GenerateMessage())
              ..add(ListPersonScreenOpened()),
        child: const PersonPage(),
      ),
    );
  }
}
