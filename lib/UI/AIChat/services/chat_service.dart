import 'package:jak_sie_masz/Data/repositories/user_repository.dart';
import 'package:jak_sie_masz/Data/services/shared_preferences_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../models/message.dart';

class ChatService {
  SharedPreferencesService sp = SharedPreferencesService();
  UserRepository userRepository;

  ChatService({required this.userRepository});

  static IO.Socket? _socket;
  String? _serverIp = "";

  void Function(Message)? onMessageReceived;
  void Function()? onTypingStarted;
  void Function()? onTypingStopped;
  void Function()? onConnected;
  void Function()? onDisconnected;
  void Function(String)? onError;

  String? get serverIp => _serverIp;

  Future<void> connectToServer() async {
    _serverIp = await sp.fetchString("ip_addr");

    print('Connecting to $_serverIp');
    try {
      if (_socket != null) {
        if (!_socket!.connected) {
          _socket!.connect();
        }
        setupSocketListeners();
        return;
      }
      //todo change to use saved address
      // 'http://10.0.2.2:3000'
      _socket = IO.io(_serverIp, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'reconnection': true,
        'reconnectionAttempts': 5,
        'reconnectionDelay': 1000,
      });

      setupSocketListeners();

      _socket!.onConnect((_) {
        print('Socket connected');
        onConnected?.call();
      });

      _socket!.onDisconnect((_) {
        print('Socket disconnected');
        onDisconnected?.call();
      });

      _socket!.onConnectError((err) {
        print('Connect Error: $err');
        onDisconnected?.call();
      });
      _socket!.onError(
        (err) {
          print('Socket Error: $err');
          onDisconnected?.call();
        },
      );
    } catch (e) {
      _serverIp = await sp.fetchString("ip_addr") as String;
      print('Error in connectToServer: $e');
    }
  }

  Future<void> changeServer() async {
    if (_serverIp != await sp.fetchString("ip_addr") || _socket == null) {
      // if server ip is different connect to the new one
      _socket?.disconnect();
      _socket?.dispose();
      _socket = null;
      connectToServer();
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

    _socket!.on('error', (errorMessage) {
      print('Error from server: $errorMessage');
      onError?.call(errorMessage);
    });
  }

  void sendMessage(String message, {String context = ''}) {
    print("nazwa bota to jest kurwa ${userRepository.aiName}");
    _socket?.emit('sendMessage', {
      'message': message,
      'context': context,
      'aiName': userRepository.aiName,
      'username': userRepository.username,
    });
  }

  void dispose() {
    _socket?.disconnect();
    _socket?.dispose();
  }
}
