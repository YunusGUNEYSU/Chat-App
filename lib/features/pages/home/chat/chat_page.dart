// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/features/provider/message_provider.dart';
import 'package:chat_app/features/widgets/chat_bubble.dart';
import 'package:chat_app/features/widgets/my_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverId;
  const ChatPage({
    Key? key,
    required this.receiverEmail,
    required this.receiverId,
  }) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final TextEditingController _messageController;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      context.read<MessageProvider>().sendMessage(widget.receiverId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(child: _getMessageList()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: _messageInputField(),
          ),
        ],
      ),
    );
  }

  Widget _getMessageList() {
    return StreamBuilder(
      stream: context
          .read<MessageProvider>()
          .getMessage(widget.receiverId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error :${snapshot.hasError}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }
        return ListView(
          children: snapshot.data!.docs.map((doc) => _getMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _getMessageItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    var aligment = data['senderId'] == _firebaseAuth.currentUser!.uid
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: aligment,
      child: Column(
        crossAxisAlignment: data['senderId'] == _firebaseAuth.currentUser!.uid
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        mainAxisAlignment: data['senderId'] == _firebaseAuth.currentUser!.uid
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          //Text(data['senderEmail'], style: Theme.of(context).textTheme.titleMedium),
          ChatBubble(message: data['message'])
        ],
      ),
    );
  }

  Widget _messageInputField() {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: MyTextFormField(
              textEditingController: _messageController,
              hintText: 'Enter your message',
              isObsecure: false),
        ),
        Expanded(
          flex: 1,
          child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.send,
                size: 30,
              )),
        )
      ],
    );
  }
}
