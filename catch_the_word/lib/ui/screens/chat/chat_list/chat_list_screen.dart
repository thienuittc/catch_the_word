import 'package:catch_the_word/core/global/global_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/firebase/interfaces/ifirebase_message.dart';
import '../../../../core/global/locator.dart';
import '../../../../core/global/router.dart';
import '../../../../core/model_ui/user_ui_model.dart';
import '../../../base_screen/base_screen.dart';

class ChatListScreen extends BaseScreen {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build() {
    return _ChatListScreen();
  }
}

class _ChatListScreen extends StatelessWidget {
  const _ChatListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("Chats"),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            TextButton(
                child: Text("Friend list"),
                onPressed: () {
                  locator<IFirebaseMessageService>().chatList();
                }),
            StreamBuilder<QuerySnapshot<UserModelUI>>(
                stream:
                    locator<IFirebaseMessageService>().chatList().snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final data = snapshot.requireData;

                  return Column(
                    children: data.docs
                        .where((element) =>
                            element.data().id != locator<GlobalData>().user.id)
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              Get.toNamed(MyRouter.chatConversation,
                                  arguments: e.data());
                            },
                            child: ListTile(
                              title: Text(e.data().name),
                            ),
                          ),
                        )
                        .toList(),
                  );
                }),
          ],
        )),
      ),
    );
  }
}
