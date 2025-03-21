import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/AIChat/mic_button_widget.dart';
import 'package:jak_sie_masz/UI/AIChat/widgets/drawer_icon.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/access_button_widget.dart';
import 'package:provider/provider.dart';
import 'viewmodels/aichat_viewmodel.dart';
import 'widgets/chat_drawer_widget.dart';
import 'widgets/chat_message_list_widget.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key, required this.viewModel});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();

  final AIChatViewModel viewModel;
}

class _AIChatScreenState extends State<AIChatScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _drawerController;
  late Animation<double> _drawerAnimation;
  late AnimationController _dotsController;
  late List<Animation<double>> _dotsAnimations;

  @override
  void initState() {
    super.initState();

    widget.viewModel.getAiName();
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

  void _scrollToBottom() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutCubic);
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
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Consumer<AIChatViewModel>(
      builder: (context, viewModel, child) {
        return Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: const Text("AI Chat"),
                actions: [
                  Consumer<AIChatViewModel>(
                    builder: (context, viewModel, _) {
                      viewModel.changeServer();
                      return Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: viewModel.isConnected
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            viewModel.isConnected ? "Online" : "Offline",
                            style: TextStyle(
                              fontSize: Styles.fontSizeH3,
                              fontFamily: Styles.fontFamily,
                              fontWeight: FontWeight.w500,
                              color: viewModel.isConnected
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      );
                    },
                  ),
                ],
                leading: IconButton(
                  icon: const DrawerIcon(),
                  onPressed: () {
                    viewModel.toggleDrawer();
                    if (viewModel.isDrawerOpen) {
                      _drawerController.forward();
                    } else {
                      _drawerController.reverse();
                    }
                  },
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ChatMessageListWidget(
                      viewModel: viewModel,
                      scrollController: _scrollController,
                      dotsAnimations: _dotsAnimations,
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
                      margin: EdgeInsets.only(
                        bottom:
                            (keyboardHeight - 64) > 0 ? keyboardHeight - 64 : 0,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_downward_rounded),
                            color: Colors.grey,
                            onPressed: () {
                              _scrollToBottom();
                            },
                          ),
                          Expanded(
                              child: TextField(
                            controller: _messageController,
                            decoration: const InputDecoration(
                              hintText: 'Zapytaj o cokolwiek',
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20),
                            ),
                            style: TextStyle(
                              color: Styles.fontColorDark,
                              fontSize: Styles.fontSizeH4,
                              fontFamily: Styles.fontFamily,
                              fontWeight: FontWeight.normal,
                            ),
                          )),
                          Row(children: [
                            IconButton(
                              icon: const Icon(Icons.send, color: Colors.grey),
                              onPressed: () {
                                if (_messageController.text.isNotEmpty) {
                                  viewModel
                                      .sendMessage(_messageController.text);
                                  _messageController.clear();
                                }
                              },
                            ),
                            MicButtonWidget(
                                textEditingController: _messageController)
                          ])
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ChatDrawerWidget(
              viewModel: viewModel,
              drawerController: _drawerController,
              drawerAnimation: _drawerAnimation,
            ),
            AccessButtonWidget(
              bottom: 64,
              viewmodel: context.read(),
            )
          ],
        );
      },
    );
  }
}
