import 'package:chatter/widgets/chat.dart';
import 'package:chatter/widgets/new_message.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../widgets/chat.dart';
import '../widgets/new_message.dart';
//import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onMessage: (msg) {
        print(msg);
        return;
      },
      onLaunch: (msg) {
        print(msg);
        return;
      },
      onResume: (msg) {
        print(msg);
        return;
      },
    );

    super.initState();
  }

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
