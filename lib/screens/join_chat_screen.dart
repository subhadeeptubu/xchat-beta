import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JoinChatScreen extends StatefulWidget {
  @override
  _JoinChatScreenState createState() => _JoinChatScreenState();
}

class _JoinChatScreenState extends State<JoinChatScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _errorText;

  void _joinChat() {
    if (_isValidRoomId(_controller.text)) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatRoomScreen(roomId: _controller.text)),
      );
    } else {
      setState(() {
        _errorText = 'Invalid Room ID. Please enter a valid Room ID.';
      });
    }
  }

  void _pasteRoomId() async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData != null && _isValidRoomId(clipboardData.text!)) {
      setState(() {
        _controller.text = clipboardData.text!;
        _errorText = null;
      });
    } else {
      setState(() {
        _errorText =
            'Invalid Room ID in clipboard. Please enter a valid Room ID.';
      });
    }
  }

  bool _isValidRoomId(String roomId) {
    final validCharacters = RegExp(r'^[a-zA-Z0-9]{16}$');
    return validCharacters.hasMatch(roomId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Join Chat')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Room ID',
                errorText: _errorText,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
              ],
              maxLength: 16,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _joinChat,
              child: Text('Join Chat'),
            ),
            ElevatedButton(
              onPressed: _pasteRoomId,
              child: Text('Paste Room ID'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatRoomScreen extends StatelessWidget {
  final String roomId;

  ChatRoomScreen({required this.roomId});

  void _leaveChat(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room $roomId'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => _leaveChat(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              // Add your message widgets here
              children: [
                // Example message
                ListTile(
                  title: Text('User 1'),
                  subtitle: Text('Hello!'),
                ),
                ListTile(
                  title: Text('User 2'),
                  subtitle: Text('Hi there!'),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Handle message sending
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
