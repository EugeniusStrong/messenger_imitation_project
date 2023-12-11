import 'package:flutter/material.dart';
import '../widgets/person_view_widget.dart';

class ListPersonsPage extends StatelessWidget {
  const ListPersonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
        ),
        child: const PersonView(),
      ),
    );
  }
}
