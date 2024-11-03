import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class ApiService {
  final String apiUrl = 'http://192.168.0.102:8080/api';

  Future<List<dynamic>> getChatRooms() async {
    final response = await http.get(Uri.parse('$apiUrl/chat_rooms'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("Chat rooms data: $data");  // 응답 데이터를 출력해서 확인
      return data;
    } else {
      throw Exception('Failed to load chat rooms');
    }
  }

  Future<Map<String, dynamic>> createChatRoom(String title) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    String userId = user.uid; // 사용자 고유 ID 사용
    final response = await http.post(
      Uri.parse('$apiUrl/chat_rooms'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'chatTitle': title,
        'userId': userId, // Firebase 사용자 고유 ID 사용
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create chat room');
    }
  }

  Future<String> getIdToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? token = await user.getIdToken();
      if (token != null) {
        return token;
      } else {
        throw Exception('Failed to retrieve ID token');
      }
    } else {
      throw Exception('User not logged in');
    }
  }

  Future<List<dynamic>> getChatRoomMessages(String chatRoomId) async {
    final response = await http.get(Uri.parse('$apiUrl/chat_rooms/$chatRoomId/contextUsers'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
