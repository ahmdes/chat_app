import 'package:chat_app/presentation/Views/Authentication/sign_in.dart';
import 'package:chat_app/presentation/Views/Authentication/sign_up.dart';
import 'package:flutter/material.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SignIn.id,
      routes: {
        SignUp.id: (context) => SignUp(),
        SignIn.id: (context) => SignIn(),
      },
    );
  }
}
