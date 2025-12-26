import 'package:chat_app/Behaviour/Constants/colors_constants.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.data, required this.bubbleType});
  final String data;
  final String bubbleType;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          bubbleType == "right" ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color:
              bubbleType == "right"
                  ? ColorsConstants.kBlue
                  : ColorsConstants.kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
            bottomLeft: Radius.circular(bubbleType == "right" ? 35 : 0),
            bottomRight: Radius.circular(bubbleType == "right" ? 0 : 35),
          ),
        ),
        child: Text(
          data,
          style: TextStyle(
            color: ColorsConstants.kWhite,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
