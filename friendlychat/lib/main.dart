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

// feature 'Animation'
// add TickerProviderStateMixin in the class definition, so
// ChatScreenState can receive a vsync argument and be animated
class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  // Add state variable OUTSIDE of the build function
  final TextEditingController _textController = TextEditingController();
  // feature 'Message'
  final List<ChatMessage> _messages = <ChatMessage>[];

  // Add functions OUTSIDE of the build function !
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(
                    hintText: "Send your message"),
              ),
            ),
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
    ChatMessage message = ChatMessage(
      text: text,
      // feature 'Animation'
      // Create a new ChatMessage that will be build with
      // an animation controller 
      animationController: AnimationController(
        duration: Duration(milliseconds: 200),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    // feature 'Animation'
    // Start the animation
    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("FriendlyChat")),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
  // feature 'Animation'
  // to remove the animation widget when ChatScreenState is
  // not on screen 
  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  final String text;
  // feature 'Animation'
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    // feature 'Animation'
    // Building ChatMessage will be done with a SizeTransition animation
    // on a Container widget holding the content of ChatMessage.
    // the 'content' Container is wrapped in SizeTransition widget controlled
    // by the animationController passed at initialization 
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      // Content of the ChatMessage widget
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: Text(_name[0])),
            ),
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
      ),
    );
  }
}
