import 'dart:convert';

import 'package:catch_the_word/core/global/global_data.dart';
import 'package:catch_the_word/core/global/router.dart';
import 'package:catch_the_word/ui/screens/home_screen/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/firebase/interfaces/ifirebase_message.dart';
import '../../../../core/global/locator.dart';
import '../../../../core/model_ui/image_ui_model.dart';
import '../../../../core/model_ui/user_ui_model.dart';
import '../../../base_screen/base_screen.dart';
import '../../draw_screen/draw_screen.dart';

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
  String groupChatId = "";
  bool _isComposing = false;
  UserModelUI currentUser = locator<GlobalData>().user;
  @override
  void initState() {
    if (currentUser.id.compareTo(widget.friend.id) > 0) {
      groupChatId = '${currentUser.id}-${widget.friend.id}';
    } else {
      groupChatId = '${widget.friend.id}-${currentUser.id}';
    }
    super.initState();
  }

  Future _sendMessage() async {
    final message = _messageController.text.trim();
    setState(() {
      _messageController.clear();
      _isComposing = false;
    });
    await locator<IFirebaseMessageService>()
        .sendMessage(message, currentUser.id, groupChatId, 1);
  }

  Widget _buildComposer() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              Get.toNamed(MyRouter.draw,
                  arguments: DrawScreenArguments(
                      currentUserId: currentUser.id, groupId: groupChatId));
            },
            icon: const Icon(Icons.gamepad_outlined),
            color: Colors.blue,
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              focusNode: _messageFocusNode,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 20.r, horizontal: 10.r),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    16.r,
                  ),
                ),
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
              stream:
                  locator<IFirebaseMessageService>().messageStream(groupChatId),
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
                      if (docs[index]['senderId'] != currentUser.id) {
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
                                child: docs[index]['type'] == 1
                                    ? Text(
                                        docs[index]['message'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    : _Image(
                                        messageId: docs[index].id,
                                        imageId: docs[index]['message'],
                                        isRead: docs[index]['isRead'] == '1',
                                        groupId: groupChatId,
                                      ),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(currentUser.name),
                            Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(8.0),
                                ),
                              ),
                              color: Colors.blueAccent,
                              elevation: 0.0,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: docs[index]['type'] == 1
                                    ? Text(
                                        docs[index]['message'],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                        ),
                                      )
                                    : _Image(
                                        messageId: docs[index].id,
                                        imageId: docs[index]['message'],
                                        isRead: docs[index]['isRead'] == '1',
                                        groupId: groupChatId,
                                      ),
                              ),
                            ),
                            const SizedBox(height: 4.0),
                          ],
                        );
                      }
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

class _Image extends StatelessWidget {
  const _Image({
    super.key,
    required this.imageId,
    required this.isRead,
    required this.messageId,
    required this.groupId,
  });
  final String imageId;
  final bool isRead;
  final String messageId;
  final String groupId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        ImageUIModel image =
            await locator<IFirebaseMessageService>().getImage(imageId);
        image.messageId = messageId;
        image.groupId = groupId;
        Get.toNamed(MyRouter.home,
            arguments: HomeScreenArguments(
                picture: image));
      },
      child: Container(
        width: 100.r,
        height: 100.r,
        color: Colors.amber,
        child: Center(child: Text("?")),
      ),
    );
  }
}
