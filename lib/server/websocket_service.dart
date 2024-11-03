import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class WebSocketService {
  StompClient? stompClient;

  void connect(String chatRoomId, Function(String) onMessageReceived) {
    stompClient = StompClient(
      config: StompConfig.SockJS(
        url: 'http://192.168.0.102:8080/ws',
        onConnect: (frame) {
          print('Connected to WebSocket');
          stompClient?.subscribe(
            destination: '/topic/public',
            callback: (frame) {
              onMessageReceived(frame.body!);
            },
          );
        },
        onWebSocketError: (dynamic error) => print('WebSocket Error: $error'),
      ),
    );
    stompClient?.activate();
  }

  void sendMessage(String message, String chatRoomId) {
    if (stompClient != null && stompClient!.connected) {
      stompClient?.send(
        destination: '/app/sendMessage',
        body: '{"message": "$message", "chatRoomId": "$chatRoomId"}',
      );
      print('Sending JSON: {"message": "$message", "chatRoomId": "$chatRoomId"}');
    } else {
      print('WebSocket is not connected');
    }
  }

  void disconnect() {
    stompClient?.deactivate();
    print('WebSocket disconnected');
  }
}
