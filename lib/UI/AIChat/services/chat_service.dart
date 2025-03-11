import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../models/message.dart';

class ChatService {
  static IO.Socket? _socket;

  void Function(Message)? onMessageReceived;
  void Function()? onTypingStarted;
  void Function()? onTypingStopped;

  void connectToServer() {
    try {
      if (_socket != null) {
        if (!_socket!.connected) {
          _socket!.connect();
        }
        setupSocketListeners();
        return;
      }

      _socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'reconnection': true,
        'reconnectionAttempts': 5,
        'reconnectionDelay': 1000,
      });

      setupSocketListeners();

      _socket!.onConnect((_) => print('Socket connected'));
      _socket!.onDisconnect((_) => print('Socket disconnected'));
      _socket!.onConnectError((err) => print('Connect Error: $err'));
      _socket!.onError((err) => print('Socket Error: $err'));
    } catch (e) {
      print('Error in connectToServer: $e');
    }
  }

  void setupSocketListeners() {
    _socket!.on('botStartedTyping', (_) {
      print('Bot started typing');
      onTypingStarted?.call();
    });

    _socket!.on('botStoppedTyping', (_) {
      print('Bot stopped typing');
      onTypingStopped?.call();
    });

    _socket!.on('receiveMessage', (data) {
      print('Received message from server: $data');
      onMessageReceived?.call(Message(data['text'], true));
    });
  }

  void sendMessage(String message, {String context = ''}) {
    _socket?.emit('sendMessage', {
      'message': message,
      'context': context,
    });
  }

  void dispose() {
    _socket?.disconnect();
    _socket?.dispose();
  }
}
