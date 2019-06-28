import 'package:flutter/material.dart';

const String _name = "Tristan";

void main() {
  runApp(new FriendlychatApp());
}

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Friendlychat",
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  // Add state variable OUTSIDE of the build function
  final TextEditingController _textController = TextEditingController();

  // Add functions OUTSIDE of the build function
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      // The main Container is wrapped in IconTheme to send
      // color parameters to the Send icon
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        // Use Row widget to horizontally align a series of
        // widget
        child: Row(
          children: <Widget>[
            // Textfield to write message
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(
                    hintText: "Send your message"),
              ),
            ),
            // Button to send written messages
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  } // End of _buildTextComposer()

  void _handleSubmitted(String text) {
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("FriendlyChat")),
      body: _buildTextComposer(),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text});
  final String text;

  @override 
  Widget build(BuildContext context) {
    return Container (
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      // Row to contain an avatar and a bloc of 2 vertically 
      // stacked Text, horizontally distributed 
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container to position the avatar
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(child: Text(_name[0])),
          ),
          // Container to position the texts
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(_name, style: Theme.of(context).textTheme.subhead),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text(text),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
