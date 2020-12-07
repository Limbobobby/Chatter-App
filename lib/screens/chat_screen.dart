import 'package:chatter/widgets/chat.dart';
import 'package:chatter/widgets/new_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/chat.dart';
import '../widgets/new_message.dart';
//import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatter App'),
        actions: <Widget>[
          DropdownButton(
              icon: Icon(Icons.more_vert),
              items: [
                DropdownMenuItem(
                    child: Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.exit_to_app,
                          ),
                          SizedBox(width: 3),
                          Text('logout'),
                        ],
                      ),
                    ),
                    value: 'logout'),
              ],
              onChanged: (itemidentifyer) {
                if (itemidentifyer == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              })
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () => Firestore.instance
      //       .collection('chats/7LD1Zjk7KPpFrua1srIC/messages')
      //       .add({'text': 'this was added by button'}),
      // ),
    );
  }
}
