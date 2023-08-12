import 'package:flutter/material.dart';
import 'package:messenger_imitation_project/models/person_with_messages.dart';

class InfoPersonPage extends StatelessWidget {
  final PersonWithMessages personWithMessages;

  const InfoPersonPage({required this.personWithMessages, super.key});

  @override
  Widget build(BuildContext context) {
    final personInfo = personWithMessages.person;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_rounded))
                ],
              ),
              Text(
                ' ${personInfo.name.title}. ${personInfo.name.first} ${personInfo.name.last} ',
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(personInfo.picture.large),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.alternate_email_sharp,
                    color: Colors.green,
                    size: 25,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    personInfo.email,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              ...buildText('Phone:', personInfo.phone),
              ...buildText('Messenger ID:', personInfo.cell),
              ...buildText('Nationality:', personInfo.nat),
              Icon(
                personInfo.gender == 'female' ? Icons.woman : Icons.man,
                size: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildText(String text, String value) {
    return [
      Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      const SizedBox(
        height: 12,
      ),
    ];
  }
}
