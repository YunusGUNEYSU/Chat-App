import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderEmail;
  final String senderId;
  final String recieverId;
  final String message;
  final Timestamp timestamp;

  MessageModel(
      {required this.senderId,
      required this.recieverId,
      required this.message,
      required this.timestamp,
      required this.senderEmail});
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'recieverId': recieverId,
      'senderEmail': senderEmail,
      'message': message,
      'timeStap': timestamp
    };
  }
}
