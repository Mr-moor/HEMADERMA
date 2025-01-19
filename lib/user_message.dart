import'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'message_database.dart';

class UserMessageScreen extends StatefulWidget {
  final int id; // User ID
  final int doctorId; // Doctor ID

  UserMessageScreen({required this.id, required this.doctorId});

  @override
  _UserMessageScreenState createState() => _UserMessageScreenState();
}

class _UserMessageScreenState extends State<UserMessageScreen> {
  bool isShowSticker = false;
  String message = '';
  final TextEditingController _controller = TextEditingController();
  List<Message> messages = []; // List to hold messages

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    final messages = await DatabaseHelper.instance.getMessages(widget.id, widget.doctorId);
    setState(() {}); // Refresh UI
  }

  Future<bool> onBackPress() {
    if (isShowSticker) {
      setState(() {
        isShowSticker = false;
      });
      return Future.value(false);
    } else {
      Navigator.pop(context);
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages with Doctor'),
      ),
      body: WillPopScope(
        onWillPop: onBackPress,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[index];
                      return ListTile(
                        title: Text(msg.message),
                        subtitle: Text(msg.timestamp),
                      );
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      // Button send image
                      Material(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 1.0),
                          child: IconButton(
                            icon: Icon(Icons.image),
                            onPressed: () {
                              // Handle image sending
                            },
                            color: Colors.blueGrey,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      // Emoji picker button
                      Material(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 1.0),
                          child: IconButton(
                            icon: Icon(Icons.face),
                            onPressed: () {
                              setState(() {
                                isShowSticker = !isShowSticker;
                              });
                            },
                            color: Colors.blueGrey,
                          ),
                        ),
                        color: Colors.white,
                      ),
                      // Message input field
                      Flexible(
                        child: Container(
                          child: TextField(
                            controller: _controller,
                            onChanged: (value) {
                              message = value; // Update message with input
                            },
                            style: TextStyle(color: Colors.blueGrey, fontSize: 15.0),
                            decoration: InputDecoration.collapsed(
                              hintText: 'Type your message...',
                              hintStyle: TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                        ),
                      ),
                      // Button send message
                      Material(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () async {
                              if (message.isNotEmpty) {
                                await DatabaseHelper.instance.insertMessage(widget.id, widget.doctorId, message);
                                _loadMessages(); // Refresh messages
                                _controller.clear(); // Clear the input field
                                setState(() {
                                  message = ''; // Reset message
                                });
                              }
                            },
                            color: Colors.blueGrey,
                          ),
                        ),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  width: double.infinity,
                  height: 50.0,
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.blueGrey, width: 0.5)),
                    color: Colors.white,
                  ),
                ),
                // Emoji Picker
                if (isShowSticker) buildSticker(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build emoji picker using emoji_picker_flutter
  Widget buildSticker() {
    return EmojiPicker(
      onEmojiSelected: (category, emoji) {
        setState(() {
          message += emoji.emoji; // Add selected emoji to the message
          _controller.text = message; // Update the TextField
          _controller.selection = TextSelection.fromPosition(TextPosition(offset: message.length)); // Move cursor to the end
        });
      },
    );
  }
}
