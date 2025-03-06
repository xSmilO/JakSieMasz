import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Message {
  final String text;
  final bool isBot;
  Message(this.text, this.isBot);
}

class Topic {
  final String text;
  final DateTime timestamp;

  Topic(this.text, this.timestamp);
}

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();
  static IO.Socket? _socket;
  bool isTyping = false;
  bool isDrawerOpen = false;
  late AnimationController _drawerController;
  late Animation<double> _drawerAnimation;
  late AnimationController _dotsController;
  late List<Animation<double>> _dotsAnimations;

  // Lista przykładowych tematów z czasami
  final List<Topic> recentTopics = [
    Topic("Jak radzić sobie ze stresem?",
        DateTime.now().subtract(const Duration(hours: 2))),
    Topic("Techniki relaksacji",
        DateTime.now().subtract(const Duration(hours: 5))),
    Topic("Zdrowe nawyki życiowe",
        DateTime.now().subtract(const Duration(days: 2))),
    Topic("Medytacja dla początkujących",
        DateTime.now().subtract(const Duration(days: 3))),
    Topic(
        "Zarządzanie czasem", DateTime.now().subtract(const Duration(days: 5))),
    Topic(
        "Sztuka komunikacji", DateTime.now().subtract(const Duration(days: 8))),
    Topic("Rozwój osobisty", DateTime.now().subtract(const Duration(days: 15))),
    Topic(
        "Work-life balance", DateTime.now().subtract(const Duration(days: 25))),
  ];

  List<Topic> get todayTopics => recentTopics
      .where((topic) => topic.timestamp
          .isAfter(DateTime.now().subtract(const Duration(days: 1))))
      .toList();

  List<Topic> get lastWeekTopics => recentTopics
      .where((topic) =>
          topic.timestamp
              .isAfter(DateTime.now().subtract(const Duration(days: 7))) &&
          topic.timestamp
              .isBefore(DateTime.now().subtract(const Duration(days: 1))))
      .toList();

  List<Topic> get lastMonthTopics => recentTopics
      .where((topic) =>
          topic.timestamp
              .isAfter(DateTime.now().subtract(const Duration(days: 30))) &&
          topic.timestamp
              .isBefore(DateTime.now().subtract(const Duration(days: 7))))
      .toList();

  @override
  void initState() {
    super.initState();
    connectToServer();
    _drawerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _drawerAnimation = Tween<double>(
      begin: -1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _drawerController,
      curve: Curves.easeInOut,
    ));

    // Inicjalizacja animacji kropek
    _dotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _dotsAnimations = List.generate(3, (index) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _dotsController,
          curve: Interval(
            index * 0.2,
            0.6 + index * 0.2,
            curve: Curves.easeInOut,
          ),
        ),
      );
    });
  }

  void connectToServer() {
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
    });

    setupSocketListeners();
  }

  void setupSocketListeners() {
    _socket!.onConnect((_) {
      print('Connected to server');
    });

    _socket!.on('botStartedTyping', (_) {
      if (mounted) {
        setState(() {
          isTyping = true;
        });
      }
    });

    _socket!.on('botStoppedTyping', (_) {
      if (mounted) {
        setState(() {
          isTyping = false;
        });
      }
    });

    _socket!.onConnectError((data) {
      print('Connection Error: $data');
    });

    _socket!.onError((data) {
      print('Socket Error: $data');
    });

    _socket!.on('receiveMessage', (data) {
      print('Received message from server: $data');
      if (mounted) {
        setState(() {
          _messages.add(Message(data['text'], data['isBot']));
        });
        WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      }
    });

    _socket!.on('error', (data) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data.toString())),
        );
      }
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      final message = _messageController.text;
      setState(() {
        _messages.add(Message(message, false));
      });
      _socket?.emit('sendMessage', message);
      _messageController.clear();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _toggleDrawer() {
    setState(() {
      isDrawerOpen = !isDrawerOpen;
      if (isDrawerOpen) {
        _drawerController.forward();
      } else {
        _drawerController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _drawerController.dispose();
    _dotsController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("AI Chat"),
            leading: IconButton(
              icon: SizedBox(
                width: 24,
                height: 24,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 18,
                      height: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 14,
                      height: 2,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 10,
                      height: 2,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              onPressed: _toggleDrawer,
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: _messages.isEmpty && !isTyping
                    ? const Center(
                        child: Text(
                          "W czym ci pomóc?",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: _messages.length + (isTyping ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == _messages.length && isTyping) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.all(8.0),
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    const Text(
                                      "Andrzej Bugała pisze",
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(3, (dotIndex) {
                                        return FadeTransition(
                                          opacity: _dotsAnimations[dotIndex],
                                          child: const Text(
                                            ".",
                                            style: TextStyle(
                                              fontSize: 14,
                                              height: 1,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          final message = _messages[index];
                          return Align(
                            alignment: message.isBot
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: message.isBot
                                    ? Colors.grey[300]
                                    : Colors.greenAccent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(message.text),
                            ),
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _messageController,
                          decoration: const InputDecoration(
                            hintText: 'Zapytaj o cokolwiek',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.grey),
                          onPressed: sendMessage,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedBuilder(
          animation: _drawerAnimation,
          builder: (context, child) {
            return Stack(
              children: [
                if (isDrawerOpen)
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: _toggleDrawer,
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                Positioned(
                  left: MediaQuery.of(context).size.width *
                      _drawerAnimation.value,
                  top: MediaQuery.of(context).padding.top,
                  bottom: 0,
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Material(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          height: kToolbarHeight,
                          child: Row(
                            children: [
                              IconButton(
                                icon: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 18,
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        width: 14,
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        width: 10,
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: _toggleDrawer,
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 1),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: [
                              if (todayTopics.isNotEmpty) ...[
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      16.0, 32.0, 16.0, 4.0),
                                  child: Text(
                                    "Dzisiaj",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                ...todayTopics.map((topic) => ListTile(
                                      dense: true,
                                      visualDensity:
                                          const VisualDensity(vertical: -4),
                                      title: Text(
                                        topic.text,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${topic.timestamp.hour}:${topic.timestamp.minute.toString().padLeft(2, '0')}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onTap: () {
                                        _toggleDrawer();
                                      },
                                    )),
                              ],
                              if (lastWeekTopics.isNotEmpty) ...[
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      16.0, 32.0, 16.0, 4.0),
                                  child: Text(
                                    "Ostatnie 7 dni",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                ...lastWeekTopics.map((topic) => ListTile(
                                      dense: true,
                                      visualDensity:
                                          const VisualDensity(vertical: -4),
                                      title: Text(
                                        topic.text,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${topic.timestamp.day}/${topic.timestamp.month}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onTap: () {
                                        _toggleDrawer();
                                      },
                                    )),
                              ],
                              if (lastMonthTopics.isNotEmpty) ...[
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      16.0, 32.0, 16.0, 4.0),
                                  child: Text(
                                    "Ostatnie 30 dni",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                ...lastMonthTopics.map((topic) => ListTile(
                                      dense: true,
                                      visualDensity:
                                          const VisualDensity(vertical: -4),
                                      title: Text(
                                        topic.text,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${topic.timestamp.day}/${topic.timestamp.month}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onTap: () {
                                        _toggleDrawer();
                                      },
                                    )),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
