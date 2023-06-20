import 'package:chat_app/core/constants/firebase_constants.dart';
import 'package:chat_app/features/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IMessageService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  Future<void> sendMessage(String recieverId, String message);
  Stream<QuerySnapshot> getMessage(String userId, String otherUserId);
}

class MessageService extends IMessageService {
  @override
  Future<void> sendMessage(String recieverId, String message) async {
    final String senderId = _firebaseAuth.currentUser!.uid;
    final String senderEmail = _firebaseAuth.currentUser?.email.toString() ?? '';
    final Timestamp timeStap = Timestamp.now();
    MessageModel newMessage = MessageModel(
        senderEmail: senderEmail,
        senderId: senderId,
        recieverId: recieverId,
        message: message,
        timestamp: timeStap);
    List<String> chatId = [senderId, recieverId];
    chatId.sort();
    String chatRoomId = chatId.join('_');
    try {
      await _fireStore
          .collection(FirebaseConstants.chatroom.value)
          .doc(chatRoomId)
          .collection(FirebaseConstants.messages.value)
          .add(newMessage.toJson());
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }

  @override
  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    List<String> chatId = [userId, otherUserId];
    chatId.sort();
    String chatRoomId = chatId.join('_');
    try {
      final response = _fireStore
          .collection(FirebaseConstants.chatroom.value)
          .doc(chatRoomId)
          .collection(FirebaseConstants.messages.value)
          .orderBy('timeStap', descending: false)
          .snapshots();
      return response;
    } on FirebaseException catch (e) {
      throw Exception(e.message);
    }
  }
}
//UoW5hPfqJxQyjiU8bI8FabTT7J32_wKieC52OQEUAaZauieLSYe8gWk02