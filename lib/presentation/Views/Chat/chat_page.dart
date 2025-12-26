import 'package:chat_app/Behaviour/Constants/colors_constants.dart';
import 'package:chat_app/Behaviour/Constants/images.dart';
import 'package:chat_app/Behaviour/Constants/utilies.dart';
import 'package:chat_app/presentation/Views/Chat/widgets/chat_bubble.dart';
import 'package:chat_app/presentation/Widgets/build_text_form_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static const String id = "Chat Page";
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages = FirebaseFirestore.instance.collection(
    Utilies.chatBubbleCollection,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorsConstants.kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 55,
              width: 55,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: ColorsConstants.kWhite),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(ChatImages.kChatImage),
              ),
            ),
            Text(
              " Chat",
              style: TextStyle(
                color: ColorsConstants.kWhite,
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ChatBubble(
            data:
                "Hello , How are you Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ? ?",
            bubbleType: "right",
          ),
          ChatBubble(data: "Hello , How are you ?", bubbleType: "left"),
          ChatBubble(data: "Hello , How are you ?", bubbleType: "right"),
          ChatBubble(
            data:
                "Hello , How are you Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ?Hello , How are you ? ?",
            bubbleType: "right",
          ),
          ChatBubble(data: "Hello , How are you ?", bubbleType: "left"),
          ChatBubble(data: "Hello , How are you ?", bubbleType: "right"),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: BuildTextFormField(
          hintText: "Send Message",
          labelText: "",
          onChanged: (data) {},
          bordersColor: ColorsConstants.kPrimaryColor,
          suffixIcon: IconButton(
            onPressed: () {
              messages.add({"message": "hello i am ahmed "});
            },
            icon: Icon(
              Icons.send,
              color: ColorsConstants.kPrimaryColor,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
