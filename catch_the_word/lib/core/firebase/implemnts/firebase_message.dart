import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model_ui/user_ui_model.dart';
import '../interfaces/ifirebase_message.dart';

class FirebaseMessageService implements IFirebaseMessageService {
  final String _collection = 'messages';
  static final _firestore = FirebaseFirestore.instance;
  @override
  Stream<QuerySnapshot> messageStream(groupId) {
    return _firestore
        .collection(_collection)
        .doc('groupId')
        .collection(groupId)
        .orderBy('time', descending: true)
        .snapshots();
  }

  @override
  Future<void> sendMessage(
      String message, String senderId, String groupId,int type) async {
    await _firestore
        .collection(_collection)
        .doc("groupId")
        .collection(groupId)
        .add({
      'senderId': senderId,
      'message': message,
      'type':type,
      'time': DateTime.now(),
    });
  }

  @override
  CollectionReference<UserModelUI> chatList() {
    var data = FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModelUI>(
          fromFirestore: (snapshot, _) =>
              UserModelUI.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        );
    return data;
  }
}
