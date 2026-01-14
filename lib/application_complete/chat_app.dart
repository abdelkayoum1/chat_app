import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:frt/application_complete/chatpuble.dart';
import 'package:frt/application_complete/constant_chat.dart';
import 'package:frt/model/message.dart';

class ChatApp extends StatelessWidget {
  static String id = '/chatpp';
  CollectionReference messagee = FirebaseFirestore.instance.collection(
    kMessage,
  );

  final user = FirebaseAuth.instance.currentUser;

  TextEditingController msj = TextEditingController();

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    print(email);
    print('${user!.uid}');
    return StreamBuilder<QuerySnapshot>(
      stream: messagee.orderBy('Created', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('error${snapshot.error}'));
        }
        if (snapshot.hasData) {
          List<Message> listmessage = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            listmessage.add(Message.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyActions: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    width: 50,
                    height: 50,
                  ),
                  Text('ChataApp'),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: controller,
                    itemCount: listmessage.length,
                    itemBuilder: (context, index) {
                      return listmessage[index].id == email
                          ? Chatbubple(message: listmessage[index])
                          : ChatbubpleFriend(message: listmessage[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: msj,
                    onSubmitted: (data) {
                      messagee.add({
                        'message': data,
                        'Created': DateTime.now(),
                        'id': email.toString(),
                      });

                      msj.clear();
                      controller.animateTo(
                        0,
                        duration: Duration(microseconds: 1),
                        curve: Curves.easeIn,
                      );
                    },

                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'ecrire un message',

                      suffixIcon: Icon(Icons.send),
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('loading');
        }
      },
    );
  }
}

// ignore: must_be_immutable
class ChatAppFriend extends StatelessWidget {
  ChatAppFriend({super.key, required this.message});
  final Message message;
  static String id = '/chatpp';
  CollectionReference messagee = FirebaseFirestore.instance.collection(
    kMessage,
  );

  final user = FirebaseAuth.instance.currentUser;

  TextEditingController msj = TextEditingController();

  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    print(email);

    print('${user!.uid}');
    return StreamBuilder<QuerySnapshot>(
      stream: messagee.orderBy('Created', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('error${snapshot.error}'));
        }
        if (snapshot.hasData) {
          List<Message> listmessage = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            listmessage.add(Message.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyActions: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/scholar.png',
                    width: 50,
                    height: 50,
                  ),
                  Text('ChataApp'),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: controller,
                    itemCount: listmessage.length,
                    itemBuilder: (context, index) {
                      return ChatbubpleFriend(message: listmessage[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: msj,
                    onSubmitted: (data) {
                      messagee.add({
                        'message': data,
                        'Created': DateTime.now(),
                        'id': email.toString(),
                      });

                      msj.clear();
                      controller.animateTo(
                        0,
                        duration: Duration(microseconds: 1),
                        curve: Curves.easeIn,
                      );
                    },

                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: 'ecrire un message',

                      suffixIcon: Icon(Icons.send),
                      hintStyle: TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Text('loading');
        }
      },
    );
  }
}
