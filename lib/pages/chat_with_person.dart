import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:messenger_imitation_project/models/message.dart';
import 'package:messenger_imitation_project/models/person_model.dart';
import 'package:messenger_imitation_project/models/person_with_messages.dart';
import 'package:messenger_imitation_project/pages/about.dart';
import 'package:messenger_imitation_project/pages/info_person_page.dart';
import 'package:flutter/foundation.dart' as foundation;

enum SampleItem { itemOne, itemTwo }

class ChatWithPersonPage extends StatefulWidget {
  final PersonWithMessages personWithMessages;

  const ChatWithPersonPage({
    required this.personWithMessages,
    super.key,
  });

  @override
  State<ChatWithPersonPage> createState() => _ChatWithPersonPageState();
}

class _ChatWithPersonPageState extends State<ChatWithPersonPage> {
  final textInputController = TextEditingController();
  List<String> selectedEmojis = [];
  bool emojiShowing = false;
  late final Person _person = widget.personWithMessages.person;
  late final List<Message> _messages =
      List.from(widget.personWithMessages.messages);
  SampleItem? selectedMenu;

  @override
  void dispose() {
    textInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _messages.sort((a, b) => b.receivingTime.compareTo(a.receivingTime));
    return WillPopScope(
      onWillPop: () async {
        _updateMessages();
        Navigator.pop(
          context,
          PersonWithMessages(
            _person,
            _messages,
          ),
        );
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        _updateMessages();
                        Navigator.pop(
                          context,
                          PersonWithMessages(
                            _person,
                            _messages,
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_back_outlined),
                    ),
                    Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.indigo[400],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                    image: NetworkImage(_person.picture.large),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ' ${_person.name.first} ${_person.name.last}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 4),
                                  child: Text(
                                    _person.email,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => InfoPersonPage(
                                            personWithMessages:
                                                PersonWithMessages(
                                                    _person, _messages),
                                          )));
                            },
                            icon: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton<SampleItem>(
                      initialValue: selectedMenu,
                      // Callback that sets the selected popup menu item.
                      onSelected: (SampleItem item) {
                        setState(() {
                          selectedMenu = item;
                        });
                        if (item == SampleItem.itemOne) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InfoPersonPage(
                                personWithMessages:
                                    PersonWithMessages(_person, _messages),
                              ),
                            ),
                          );
                        }
                        if (item == SampleItem.itemTwo) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AboutMe()));
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<SampleItem>>[
                        const PopupMenuItem<SampleItem>(
                          value: SampleItem.itemOne,
                          child: Text('Просмотр контакта'),
                        ),
                        const PopupMenuItem<SampleItem>(
                          value: SampleItem.itemTwo,
                          child: Text('О разработчике'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/backGround.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: _messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final messages = _messages;
                      return Column(
                        children: [
                          Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.black54),
                            ),
                            child: Center(
                              child: Text(
                                '${messages[index].receivingTime.day}.${messages[index].receivingTime.month}.${messages[index].receivingTime.year}',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              right: messages[index].isOutgoing ? 0 : 50,
                              left: messages[index].isOutgoing ? 50 : 0,
                            ),
                            width: 350,
                            child: Card(
                              child: ListTile(
                                title: Text(messages[index].messages ?? ''),
                                subtitle: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    messages[index]
                                        .receivingTime
                                        .toString()
                                        .substring(11, 16),
                                    style:
                                        const TextStyle(color: Colors.black38),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return FractionallySizedBox(
                              heightFactor: 0.7,
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ...buildIconWithText(
                                          Icons.description_outlined,
                                          'Документ',
                                        ),
                                        ...buildIconWithText(
                                            Icons.camera_alt_outlined,
                                            'Камера'),
                                        ...buildIconWithText(
                                            Icons.image_outlined, 'Галерея'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ...buildIconWithText(
                                          Icons.headphones_outlined,
                                          'Аудио',
                                        ),
                                        ...buildIconWithText(
                                            Icons.place_outlined,
                                            'Местоположение'),
                                        ...buildIconWithText(
                                            Icons.person, 'Контакты'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.add_circle_outline_sharp,
                        size: 35,
                      ),
                    ),
                    Expanded(
                      child: Form(
                        child: TextFormField(
                          controller: textInputController,
                          onChanged: (text) {
                            setState(() {});
                            if (text.isNotEmpty) {
                              setState(() {
                                emojiShowing = false;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Начни писать что-нибудь...',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  emojiShowing = !emojiShowing;
                                });
                              },
                              icon: const Icon(
                                Icons.emoji_emotions_outlined,
                                size: 30,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              gapPadding: 2,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(35),
                              ),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(35),
                              ),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (textInputController.text.isNotEmpty ||
                            selectedEmojis.isNotEmpty) {
                          final newMessage = Message(
                            messages: textInputController.text,
                            receivingTime: DateTime.now(),
                            isOutgoing: true,
                            isRead: true,
                          );

                          setState(() {
                            _messages.add(newMessage);
                            textInputController.clear();
                            selectedEmojis.clear();
                          });
                        }
                      },
                      onLongPress: () {
                        const snackBar = SnackBar(
                          content: Text(
                              'Аудиосообщения не работает в тестовом режиме...'),
                          duration: Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Icon(
                        textInputController.text.isEmpty
                            ? Icons.keyboard_voice_outlined
                            : Icons.send,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
              Offstage(
                offstage: !emojiShowing,
                child: SizedBox(
                  height: 250,
                  child: EmojiPicker(
                    textEditingController: textInputController,
                    onBackspacePressed: () {
                      final text = textInputController.text;
                      if (text.isNotEmpty) {
                        textInputController.text =
                            text.substring(0, text.length - 1);
                        textInputController.selection =
                            TextSelection.fromPosition(TextPosition(
                                offset: textInputController.text.length));
                      }
                    },
                    onEmojiSelected: (category, emoji) {
                      _onEmojiSelected(emoji);
                    },
                    config: Config(
                      columns: 7,
                      emojiSizeMax: 32 *
                          (foundation.defaultTargetPlatform ==
                                  TargetPlatform.iOS
                              ? 1.30
                              : 1.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onEmojiSelected(Emoji emoji) {
    setState(() {
      selectedEmojis.add(emoji.emoji);
    });
  }

  void _updateMessages() {
    for (final message in _messages) {
      if (!message.isRead) {
        final index = _messages.indexOf(message);
        _messages[index] = message.copyWith(isRead: true);
      }
    }
  }

  List<Widget> buildIconWithText(IconData iconData, String text) {
    return [
      SizedBox(
        height: 100,
        width: 100,
        child: Column(
          children: [
            IconButton(
              onPressed: () {
                final snackBar = SnackBar(
                  content: Text('$text нельзя добавить в тестовом режиме...'),
                  duration: const Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pop(context);
              },
              icon: Icon(
                iconData,
                color: Colors.black,
                size: 45,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ],
        ),
      ),
    ];
  }
}
