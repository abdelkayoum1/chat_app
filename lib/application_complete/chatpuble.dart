import 'package:flutter/material.dart';
import 'package:frt/application_complete/constant_chat.dart';
import 'package:frt/model/message.dart';

class Chatbubple extends StatelessWidget {
  const Chatbubple({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        padding: EdgeInsets.only(left: 16, bottom: 30, top: 30, right: 16),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),

        child: Text(message.message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class ChatbubpleFriend extends StatelessWidget {
  const ChatbubpleFriend({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        padding: EdgeInsets.only(left: 16, bottom: 30, top: 30, right: 16),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),

        child: Text(message.message, style: TextStyle(color: Colors.blue)),
      ),
    );
  }
}
