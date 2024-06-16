import 'package:flutter/material.dart';
import 'create_chat_screen.dart';
import 'join_chat_screen.dart';
import 'settings_screen.dart';
import '../room_manager.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('XChat')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome to XChat, the secure and anonymous chat app!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (RoomManager().roomId == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateChatScreen()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ChatRoomScreen(roomId: RoomManager().roomId!)),
                  );
                }
              },
              child: Text('Create Chat'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JoinChatScreen()),
                );
              },
              child: Text('Join Chat'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              },
              child: Text('Settings'),
            ),
            SizedBox(height: 20),
            Text(
              'XChat ensures your privacy with features like self-destructing messages and end-to-end encryption.',
              style: TextStyle(fontSize: 16),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat Room $roomId')),
      body: Center(
        child: Text('Welcome to chat room $roomId'),
      ),
    );
  }
}
