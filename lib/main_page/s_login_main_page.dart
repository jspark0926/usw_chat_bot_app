import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class loginMainPage extends StatefulWidget {
  const loginMainPage({super.key});

  @override
  State<loginMainPage> createState() => _loginMainPageState();
}

class _loginMainPageState extends State<loginMainPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const HeightBox(10),
        Expanded(child: Container(color: Colors.greenAccent,)),
        const TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            labelText: 'Chat',
          ),
        ).pSymmetric(h: 10,v: 15),
      ],
    );
  }
}
