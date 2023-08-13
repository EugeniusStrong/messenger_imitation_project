import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:messenger_imitation_project/models/message.dart';
import 'package:messenger_imitation_project/models/person_with_messages.dart';
import 'package:messenger_imitation_project/pages/info_person_page.dart';
import 'package:flutter/foundation.dart' as foundation;

class MessagePage extends StatefulWidget {
  final PersonWithMessages personWithMessages;

  const MessagePage({
    required this.personWithMessages,
    super.key,
  });

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final textInputController = TextEditingController();
  List<String> selectedEmojis = [];
  late PersonWithMessages _personWithMessages;
  bool emojiShowing = false;

  @override
  void initState() {
    _personWithMessages = widget.personWithMessages;
    super.initState();
  }

  @override
  void dispose() {
    textInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.personWithMessages.messages
        .sort((a, b) => b.receivingTime.compareTo(a.receivingTime));
    return Scaffold(
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
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_outlined),
                  ),
                  Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
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
                                  image: NetworkImage(widget
                                      .personWithMessages.person.picture.large),
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
                                  ' ${_personWithMessages.person.name.first} ${widget.personWithMessages.person.name.last}'),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Text(
                                  _personWithMessages.person.email,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black38,
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
                                              widget.personWithMessages,
                                        )));
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.black,
                    ),
                  )
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
                  itemCount: _personWithMessages.messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final messages = _personWithMessages.messages;
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
                        Card(
                          child: ListTile(
                            title: Text(messages[index].messages ?? ''),
                            subtitle: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                messages[index]
                                    .receivingTime
                                    .toString()
                                    .substring(11, 16),
                                style: const TextStyle(color: Colors.black38),
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
                    onPressed: () {},
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
                  IconButton(
                    onPressed: () {
                      if (textInputController.text.isNotEmpty ||
                          selectedEmojis.isNotEmpty) {
                        final newMessage = Message(
                          messages: textInputController.text,
                          receivingTime: DateTime.now(),
                          isRead: false,
                        );

                        setState(() {
                          _personWithMessages.messages.add(newMessage);
                          textInputController.clear();
                          selectedEmojis.clear();
                        });
                      }
                    },
                    icon: Icon(
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
                        (foundation.defaultTargetPlatform == TargetPlatform.iOS
                            ? 1.30
                            : 1.0),
                    // Other configuration settings
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onEmojiSelected(Emoji emoji) {
    setState(() {
      selectedEmojis.add(emoji.emoji);
    });
  }
}
