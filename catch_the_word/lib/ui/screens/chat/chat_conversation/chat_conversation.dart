import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../core/firebase/interfaces/ifirebase_message.dart';
import '../../../../core/global/locator.dart';
import '../../../../core/model_ui/user_ui_model.dart';
import '../../../base_screen/base_screen.dart';

class ChatConversationScreen extends BaseScreen {
  const ChatConversationScreen({Key? key, required this.friend})
      : super(key: key);
  final UserModelUI friend;
  @override
  Widget build() {
    return _ChatConversation(
      friend: friend,
    );
  }
}

class _ChatConversation extends StatefulWidget {
  const _ChatConversation({Key? key, required this.friend}) : super(key: key);
  final UserModelUI friend;
  @override
  State<_ChatConversation> createState() => _ChatConversationState();
}

class _ChatConversationState extends State<_ChatConversation> {
  final _messageController = TextEditingController();
  final _messageFocusNode = FocusNode();

  bool _isComposing = false;
  Future _sendMessage() async {
    final message = _messageController.text.trim();
    setState(() {
      _messageController.clear();
      _isComposing = false;
    });
    await locator<IFirebaseMessageService>()
        .sendMessage(message, "senderId", widget.friend.id);
  }

  Widget _buildComposer() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _messageController,
              focusNode: _messageFocusNode,
              decoration: InputDecoration.collapsed(
                hintText: 'Your message here...',
              ),
              onChanged: (value) {
                setState(() {
                  _isComposing = value.isNotEmpty;
                });
              },
            ),
          ),
          IconButton(
            onPressed: _sendMessage,
            icon: Icon(Icons.send),
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          widget.friend.name,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {},
            tooltip: 'Sign out',
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: locator<IFirebaseMessageService>()
                  .messageStream(widget.friend.id),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text(
                      'No message here',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                  );
                }
                List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
                return ListView(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  children: List.generate(
                    docs.length,
                    (index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.friend.name),
                          Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8.0),
                                topRight: Radius.circular(8.0),
                                bottomLeft: Radius.circular(0.0),
                                bottomRight: Radius.circular(8.0),
                              ),
                            ),
                            color: Colors.blueGrey,
                            elevation: 0.0,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                docs[index]['message'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Divider(),
          _buildComposer(),
        ],
      ),
    );
  }
}
