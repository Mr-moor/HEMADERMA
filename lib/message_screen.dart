import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_emoji/flutter_emoji.dart'; // for emojis
import 'package:file_picker/file_picker.dart'; // for file picking
import 'package:image_picker/image_picker.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  List<String> messages = [];
  File? _image;
  final picker = ImagePicker();

  final encryptKey = encrypt.Key.fromLength(32);
  final iv = encrypt.IV.fromLength(16);
  late final encrypter = encrypt.Encrypter(encrypt.AES(encryptKey));

  Future<void> _sendMessage() async {
    String message = _messageController.text;
    final encryptedMessage = encrypter.encrypt(message, iv: iv).base64;
    setState(() {
      messages.add(encryptedMessage);
      _messageController.clear();
    });
  }

  Future<void> _deleteMessage(int index) async {
    setState(() {
      messages.removeAt(index);
    });
  }

  Future<void> _deleteImage() async {
    setState(() {
      _image = null;
    });
  }

  Future<void> _sendImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);


    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _shareDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      // Handle file sharing logic here
    }
  }

  Future<void> _shareVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      // Handle video sharing logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    var parser = EmojiParser();

    return Scaffold(
      appBar: AppBar(
        title: Text('Message Doctor'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/happy.png'), // Add your background image
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final decryptedMessage =
                        encrypter.decrypt64(messages[index], iv: iv);
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.lightBlueAccent),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(parser.emojify(decryptedMessage)),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteMessage(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (_image != null)
                Stack(
                  children: [
                    Image.file(_image!),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: _deleteImage,
                      ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.emoji_emotions),
                      onPressed: () {
                        _messageController.text +=
                            '😀😀 😃 😄 😁 😆 😅 😂 🤣 😊 😇'; // Add an emoji
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type your message',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: _sendMessage,
                    ),
                    IconButton(
                      icon: Icon(Icons.image),
                      onPressed: _sendImage,
                    ),
                    IconButton(
                      icon: Icon(Icons.attach_file),
                      onPressed: _shareDocument,
                    ),
                    IconButton(
                      icon: Icon(Icons.video_library),
                      onPressed: _shareVideo,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
