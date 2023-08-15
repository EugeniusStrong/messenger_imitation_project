import 'package:flutter/material.dart';

class AboutMe extends StatelessWidget {
  const AboutMe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('РАЗРАБОТЧИК ПРИЛОЖЕНИЯ'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 150.0,
                        backgroundImage:
                            const AssetImage('assets/images/me.jpg'),
                        backgroundColor: Colors.grey[900],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Colors.grey[900],
                    child: const Text(
                      'Всем привет! Меня зовут Евгений. Я недавно начал свой путь в разработке приложений. Это одна из моих первых работ, и она является тестовым заданием. Создание этого приложения стало для меня интересным вызовом, который позволил мне применить и попрактиковать полученные знания.',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
