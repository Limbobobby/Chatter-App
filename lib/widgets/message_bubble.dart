import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:path/path.dart';

class Bubble extends StatelessWidget {
  Bubble(
    this.message,
    this.isMe,
    this.userId,
    this.userName,
    this.userUrl,
    // this.key,
  );

  final String message;
  //final Key key;
  final bool isMe;
  final String userId;
  final String userName;
  final String userUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              !isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:
                        !isMe ? Radius.circular(0) : Radius.circular(12),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(12)),
              ),
              width: 280,
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment:
                    !isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: <Widget>[
                  FutureBuilder(
                    future: Firestore.instance
                        .collection('users')
                        .document(userId)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text('..loading');
                      }
                      return Text(
                        snapshot.data['username'],
                        style: TextStyle(
                          color: isMe
                              ? Colors.black
                              : Theme.of(context)
                                  .accentTextTheme
                                  .headline1
                                  .color,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  Text(
                    message,
                    textAlign: !isMe ? TextAlign.start : TextAlign.end,
                    style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .headline1
                                .color),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          left: isMe ? 0 : 190,
          right: isMe ? 190 : 0,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: NetworkImage(
              userUrl,
            ),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
