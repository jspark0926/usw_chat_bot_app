import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usw_chat_bot_app/provider/auth_provider2.dart';
import 'package:usw_chat_bot_app/user_page/w_userPage.dart';
import 'package:usw_chat_bot_app/w_layout/w_default_Layout.dart';
import 'firebase_options.dart';
import 'main_page/w_main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
  // runApp(const MyApp());
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider2()),
      ],
      child: const MaterialApp(
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthProvider2 authProvider = Provider.of<AuthProvider2>(context);
  // late PageIndexProvider pageIndexProvider = Provider.of<PageIndexProvider>(context, listen: false);
  late int index;

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  List page = [
    const mainPage(),
    const userPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: DefaultLayout(
        resizeToAvoidBottomInset: true,
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
