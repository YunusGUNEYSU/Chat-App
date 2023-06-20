import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../service/message_service.dart';

class MessageProvider extends ChangeNotifier {
  final IMessageService _messageService = MessageService();
  bool _isLoading = false;
  bool get getLoading => _isLoading;
  void changeLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future<void> sendMessage(String recieverId, String message) async {
    changeLoading();
    await _messageService.sendMessage(recieverId, message);
    changeLoading();
    notifyListeners();
  }

  Stream<QuerySnapshot> getMessage(String userId, String otherUserId) {
    return _messageService.getMessage(userId, otherUserId);
  }
}
