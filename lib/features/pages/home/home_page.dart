import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/firebase_constants.dart';
import '../../provider/auth_provider.dart';
import 'chat/chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Home Page",
          ),
          actions: [
            IconButton(
                onPressed: () => context.read<AuthProvider>().signOut(),
                icon: const Icon(Icons.logout_outlined))
          ]),
      body: _userList(),
    );
  }

  Widget _userList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(FirebaseConstants.user.value).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("..ERROR");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("..Loading");
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc) => _userListItem(doc)).toList(),
        );
      },
    );
  }

  Widget _userListItem(DocumentSnapshot documentSnapshot) {
    final email = FirebaseAuth.instance.currentUser!.email;
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    if (email != data['email']) {
      return ListTile(
        title: Text(data['email']),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatPage(receiverEmail: data['email'], receiverId: data['uid']),
        )),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
