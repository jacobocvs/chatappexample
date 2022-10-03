import 'package:chatappexample/widgets/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('messages').orderBy('createdAt', descending: true).snapshots(),
        builder: (ctx, AsyncSnapshot chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = chatSnapshot.data.docs;
          return ListView.builder(
            reverse: true,
              itemCount: chatSnapshot.data.docs.length,
              itemBuilder: (ctx, index) =>
                  MessageBubble(message: chatDocs[index]['text']));
        });
  }
}
