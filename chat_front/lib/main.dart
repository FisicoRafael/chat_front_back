import 'package:chat_front/screen/chat_screen.dart';
import 'package:flutter/material.dart';

void main()  {
  runApp(MeuChat());
}

class MeuChat extends StatelessWidget {
  const MeuChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatConversa(),
    );
  }
}
