import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => __ChatScreenState();
}

class __ChatScreenState extends State<ChatScreen> {
  final _authentication = FirebaseAuth.instance;
  User? loggedUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser!.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat screen')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/PeUQ2ejxWgroGuDFzUez/message')
            .snapshots(),
        builder:
            (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
            ) {

              final docs = snapshot.data?.docs ?? [];

              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      docs[index]['text'],
                      style: TextStyle(fontSize: 28),
                    ),
                  );
                },
              );
            },
      ),
    );
  }
}
