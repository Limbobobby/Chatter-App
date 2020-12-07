import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (context, futureSnapShot) {
        if (futureSnapShot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
          stream: Firestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, msgSnapShot) {
            if (msgSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                reverse: true,
                itemCount: msgSnapShot.data.documents.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Bubble(
                      msgSnapShot.data.documents[index]['text'],
                      msgSnapShot.data.documents[index]['userId'] ==
                          futureSnapShot.data.uid,
                    ),
                  );
                });
          },
        );
      },
    );
  }
}
