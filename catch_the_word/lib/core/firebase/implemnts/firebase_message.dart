import 'dart:convert';

import 'package:catch_the_word/core/model_ui/image_ui_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../../model_ui/user_ui_model.dart';
import '../interfaces/ifirebase_message.dart';

class FirebaseMessageService implements IFirebaseMessageService {
  final String _messagesCollection = 'messages';
  final String _groupCollection = 'groupId';
  final String _userCollection = 'users';
  final String _imagesCollection = 'images';
  static final _firestore = FirebaseFirestore.instance;
  @override
  Stream<QuerySnapshot> messageStream(groupId) {
    return _firestore
        .collection(_messagesCollection)
        .doc(_groupCollection)
        .collection(groupId)
        .orderBy('time', descending: true)
        .snapshots();
  }

  @override
  Future<void> sendMessage(
      String message, String senderId, String groupId, int type,
      {String isRead = "0"}) async {
    await _firestore
        .collection(_messagesCollection)
        .doc(_groupCollection)
        .collection(groupId)
        .add({
      'senderId': senderId,
      'message': message,
      'type': type,
      'time': DateTime.now(),
      'isRead': isRead,
    });
  }

  @override
  CollectionReference<UserModelUI> chatList() {
    var data = FirebaseFirestore.instance
        .collection(_userCollection)
        .withConverter<UserModelUI>(
          fromFirestore: (snapshot, _) =>
              UserModelUI.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    return data;
  }

  @override
  Future<void> sendImage(
      String image, String keyword, String senderId, String groupId) async {
    await _firestore.collection(_imagesCollection).add({
      'keyword': keyword,
      'image': image,
    }).then((value) {
      sendMessage(value.id, senderId, groupId, 2);
    });
  }

  @override
  Future<ImageUIModel> getImage(String imageId) async {
    late ImageUIModel imageBase64;
    await _firestore
        .collection(_imagesCollection)
        .doc(imageId)
        .get()
        .then((value) {
      var image = value.data() as Map<String, Object?>;
      imageBase64 = ImageUIModel.fromJson(image);
    });
    return imageBase64;
  }
  
  @override
  Future<void> updateMessage(String groupId, String messageId) async {
     await _firestore
        .collection(_messagesCollection)
        .doc(_groupCollection)
        .collection(groupId)
        .doc(messageId).update({
      'isRead': '1',
    });
  }
}
