import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils.dart';
import '../room_manager.dart';

class CreateChatScreen extends StatefulWidget {
  @override
  _CreateChatScreenState createState() => _CreateChatScreenState();
}

class _CreateChatScreenState extends State<CreateChatScreen> {
  String? _roomId;

  @override
  void initState() {
    super.initState();
    _roomId = RoomManager().roomId;
  }

  void _generateRoomId() {
    if (_roomId == null) {
      String newRoomId = generateRoomId();
      RoomManager().generateRoomId(newRoomId);
      setState(() {
        _roomId = newRoomId;
      });
    }
  }

  void _goToChat() {
    if (_roomId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatRoomScreen(roomId: _roomId!)),
      );
    }
  }

  void _copyRoomId() {
    if (_roomId != null) {
      Clipboard.setData(ClipboardData(text: _roomId!));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Room ID copied to clipboard')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Chat')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_roomId == null)
              ElevatedButton(
                onPressed: _generateRoomId,
                child: Text('Generate Room ID'),
              )
            else ...[
              ElevatedButton(
                onPressed: _goToChat,
                child: Text('Go to Chat'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _copyRoomId,
                child: Text('Copy Room ID'),
              ),
            ],
            SizedBox(height: 20),
            if (_roomId != null)
              Text(
                'Room ID: $_roomId',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
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
