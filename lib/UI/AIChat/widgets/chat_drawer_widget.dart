import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import '../viewmodels/aichat_viewmodel.dart';
import 'topics_list_widget.dart';
import 'drawer_icon.dart';

class ChatDrawerWidget extends StatelessWidget {
  final AIChatViewModel viewModel;
  final AnimationController drawerController;
  final Animation<double> drawerAnimation;

  const ChatDrawerWidget({
    Key? key,
    required this.viewModel,
    required this.drawerController,
    required this.drawerAnimation,
  }) : super(key: key);

  void _closeDrawer() {
    viewModel.toggleDrawer();
    drawerController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: drawerAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            // Overlay for closing drawer
            if (viewModel.isDrawerOpen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _closeDrawer,
                  child: Container(
                    color: Colors.black.withAlpha(127),
                  ),
                ),
              ),
            Positioned(
              left: MediaQuery.of(context).size.width * drawerAnimation.value,
              top: MediaQuery.of(context).padding.top,
              bottom: 0,
              width: MediaQuery.of(context).size.width * 0.85,
              child: Material(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: kToolbarHeight,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const DrawerIcon(),
                            onPressed: _closeDrawer,
                          ),
                          const Spacer(),
                          TextButton.icon(
                            onPressed: () {
                              viewModel.startNewChat();
                              _closeDrawer();
                            },
                            icon: const Icon(Icons.add),
                            label: Text(
                              'Nowy temat',
                              style: TextStyle(
                                fontFamily: Styles.fontFamily,
                                color: Styles.primaryColor500,
                                fontWeight: FontWeight.normal,
                                fontSize: Styles.fontSizeH3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Expanded(
                      child: TopicsListWidget(
                        todayTopics: viewModel.todayTopics,
                        lastWeekTopics: viewModel.lastWeekTopics,
                        lastMonthTopics: viewModel.lastMonthTopics,
                        onTopicTap: (id) {
                          viewModel.loadChatHistory(id);
                          _closeDrawer();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
