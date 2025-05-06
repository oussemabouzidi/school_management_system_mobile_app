import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:my_app3/view/wrapper.dart';

class Chatbot extends StatefulWidget {
  const Chatbot({Key? key}) : super(key: key);

  @override
  _ChatbotState createState() => _ChatbotState();
}

class _ChatbotState extends State<Chatbot> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFE8F0FE),
      extendBody: true,
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Row(
                children: [
                  Text('Discussions',
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  Spacer(),
                  HugeIcon(
                      icon: HugeIcons.strokeRoundedBubbleChatEdit,
                      color: Colors.white)
                ],
              ),
            ),
            ListTile(
              leading: HugeIcon(
                icon: HugeIcons.strokeRoundedMessage01,
                color: const Color.fromARGB(255, 76, 73, 73),
                size: 35,
              ),
              title: Text('Chat 1'),
              onTap: () {},
            ),
            ListTile(
              leading: HugeIcon(
                icon: HugeIcons.strokeRoundedMessage01,
                color: const Color.fromARGB(255, 76, 73, 73),
                size: 35,
              ),
              title: Text('Chat 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Align(
                alignment: Alignment.topCenter,
                child: Row(children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: // Back button
                        Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) =>
                                  Wrapper(initialIndex: 0)), // home
                        ),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.grey[700],
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    child: ClipOval(
                      child: Image.asset(
                        'images/logo_home_page.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  )),
                  IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState
                          ?.openEndDrawer(); // 👈 Open Drawer
                    },
                    icon: HugeIcon(
                      icon: HugeIcons.strokeRoundedMessage01,
                      color: const Color.fromARGB(255, 76, 73, 73),
                      size: 35,
                    ),
                  )
                ])),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: Column(
                  children: [
                    Image.asset(
                      'images/chatbot_icon_screen.png',
                      width: 180,
                      height: 180,
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                            """Salut ! c’est moi votre assistant 😃
Comment puis-je vous aider? 🚀 """)
                      ],
                      totalRepeatCount: 1,
                    )
                  ],
                ),
              ),
            ),
            Container(height: screenHeight / 2.85),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Écrivez votre message",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                  suffix: IconButton(
                      onPressed: () {},
                      icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedSquareArrowRight02,
                          color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
