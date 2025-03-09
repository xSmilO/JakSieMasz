import 'package:flutter/material.dart';
import '../viewmodels/aichat_viewmodel.dart';
import 'topics_list_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: drawerAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            if (viewModel.isDrawerOpen)
              Positioned.fill(
                child: GestureDetector(
                  onTap: viewModel.toggleDrawer,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
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
                            onPressed: viewModel.toggleDrawer,
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
                        onTopicTap: viewModel.toggleDrawer,
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

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
