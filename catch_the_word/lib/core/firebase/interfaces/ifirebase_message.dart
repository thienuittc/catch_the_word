import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model_ui/user_ui_model.dart';

abstract class IFirebaseMessageService {
  Future<void> sendMessage(
      String message, String senderId, String groupId, int type);
  Stream<QuerySnapshot> messageStream(String groupId);
  CollectionReference<UserModelUI> chatList();
  Future<void> sendImage(String image, String senderId, String groupId);
  Future<String> getImage(String imageId);
}
