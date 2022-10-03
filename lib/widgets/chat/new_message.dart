import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller = new TextEditingController();

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('messages').add(
        {'text': _enteredMessage,
        'createdAt': Timestamp.now(),
       // 'userId':
        });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enviar mensaje...'),
              onChanged: (value) {
                setState((){
                  _enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(Icons.send),
          )
        ],
      ),
    );
  }
}
