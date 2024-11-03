import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../server/api_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../server/websocket_service.dart';

class ChatRoomsScreen extends StatefulWidget {
  const ChatRoomsScreen({super.key});

  @override
  _ChatRoomsScreenState createState() => _ChatRoomsScreenState();
}

class _ChatRoomsScreenState extends State<ChatRoomsScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController _chatRoomController = TextEditingController();
  List<dynamic> _chatRooms = [];
  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
      _loadChatRooms();
    } else {
      print("User not logged in");
    }
  }

  void _loadChatRooms() async {
    try {
      final chatRooms = await apiService.getChatRooms();
      final currentUserId = _userId;
      print("Current userId: $currentUserId");
      setState(() {
        _chatRooms = chatRooms.where((room) {
          print("Chat room userId: \${room['userId']}");
          return room['userId'] == currentUserId;
        }).toList();
      });
    } catch (e) {
      print("Exception caught while loading chat rooms: $e");
    }
  }

  void _createChatRoom() async {
    final chatTitle = _chatRoomController.text;
    if (chatTitle.isNotEmpty && _userId != null) {
      try {
        final chatRoom = await apiService.createChatRoom(chatTitle);
        print(
            "Chat room created successfully with id: \${chatRoom['objectId']}");
        _chatRoomController.clear();
        _loadChatRooms(); // 채팅방 생성 후 목록 새로고침
      } catch (e) {
        print("Exception caught while creating chat room: $e");
      }
    } else {
      print("Chat title is empty or user not logged in");
    }
  }

  void _navigateToChatRoom(BuildContext context, String chatRoomId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ChatRoomScreen(chatRoomId: chatRoomId), // 새로 정의한 ChatRoomScreen 사용
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          Image.asset(
            'assets/images/usw_logo.png',
            height: 45,
            width: 45,
          ).pOnly(left: 20),
          const Expanded(child: SizedBox()),
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(30),
            ),
          ).pOnly(right: 20),
        ],
      ),
      body: Column(
        children: [
          const HeightBox(30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _chatRoomController,
              decoration: const InputDecoration(
                hintText: 'Enter chat room title',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _createChatRoom,
            child: Text('채팅방 생성'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _chatRooms.length,
              itemBuilder: (context, index) {
                final chatRoom = _chatRooms[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(chatRoom['chatTitle']),
                      onTap: () =>
                          _navigateToChatRoom(context, chatRoom['objectId']),
                    ),

                    const Row(
                      children: [
                        WidthBox(10),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: 1,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.black12,
                              ),
                            ),
                          ),
                        ),
                        WidthBox(10),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChatRoomScreen extends StatefulWidget {
  final String chatRoomId;

  ChatRoomScreen({required this.chatRoomId});

  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final ApiService apiService = ApiService();
  final WebSocketService webSocketService = WebSocketService();
  List<dynamic> _messages = [];
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
    _connectWebSocket();
  }

  void _loadMessages() async {
    try {
      final messages = await apiService.getChatRoomMessages(widget.chatRoomId);
      setState(() {
        _messages = messages;
      });
    } catch (e) {
      print("Exception caught while loading messages: $e");
    }
  }

  void _connectWebSocket() {
    webSocketService.connect(widget.chatRoomId, (message) {
      print("Received message: $message");
      setState(() {
        try {
          final parsedMessage = jsonDecode(message);
          _messages.add(parsedMessage);
        } catch (e) {
          print("Error parsing message: $e");
          _messages.add({'question': message, 'answer': ''});
        }
      });
    });
  }

  void _sendMessage() {
    final message = _messageController.text;
    if (message.isNotEmpty) {
      print("Sending message: $message");
      webSocketService.sendMessage(message, widget.chatRoomId);
      setState(() {
        _messages.add({'question': message, 'answer': ''});
        _messageController.clear();
      });
    }
  }

  @override
  void dispose() {
    webSocketService.disconnect();
    super.dispose();
  }

  Widget _buildMessageBubble(String text, bool isMe) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: isMe ? Colors.blue[200] : Colors.grey[300],
        borderRadius: isMe
            ? const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
          bottomLeft: Radius.circular(14),
        )
            : const BorderRadius.only(
          topRight: Radius.circular(14),
          bottomLeft: Radius.circular(14),
          bottomRight: Radius.circular(14),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isMe = message['question'] != null;
                return Column(
                  crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    if (isMe) _buildMessageBubble(message['question'], isMe,),
                    if (message['answer'] != null &&
                        message['answer'].isNotEmpty)
                      _buildMessageBubble(message['answer'], !isMe,),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(hintText: 'Enter message'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _sendMessage,
                  child: Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
