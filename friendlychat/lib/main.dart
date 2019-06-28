import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      title: "Friendlychat",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Friendlychat"),
        ),
      ),
    ),
  );
}

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Friendlychat",
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Friendlychat")),
    );
  }
}