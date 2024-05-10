import 'package:flutter/material.dart';
import 'package:test_file/default_Layout.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'account.dart';
import 'home.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int index;
  // late int loginState;

  @override
  void initState() {
    super.initState();
    index = 0;
    // loginState = 0;
  }

  List page = [
    home(),
    account(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultLayout(
        loginState: true,
        title: 'appbar',
        child: page[index],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: index,
          onTap: (newindex) {
            setState(() {
              index = newindex;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                label: 'home',
                activeIcon: Icon(Icons.chat_bubble)),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'home',
                activeIcon: Icon(Icons.account_circle)),
          ],
        ),
      ),
    );
  }
}
