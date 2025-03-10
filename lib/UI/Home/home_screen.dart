import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Data/user_repository.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/Articles/articles_section_widget.dart';
import 'package:jak_sie_masz/UI/Home/RateChart/rate_chart_section_widget.dart';
import 'package:jak_sie_masz/UI/Home/RateDay/rate_container_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.userRepository});
  final UserRepository userRepository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<String> username;

  @override
  void initState() {
    super.initState();
    username = widget.userRepository.getUsername();
    widget.userRepository.onUsernameChange = this.loadUserName;
  }

  void loadUserName(String newUsername) {
    setState(() {
      username = widget.userRepository.getUsername();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            key: Key("green decoration box"),
            height: 200,
            decoration: BoxDecoration(
                color: Styles.primaryColor500,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF7CE9B4),
                    offset: Offset(0, 4),
                    blurRadius: 12,
                    spreadRadius: -1,
                  ),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: FutureBuilder(
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.connectionState == ConnectionState.waiting
                            ? "Witaj User"
                            : "Witaj ${snapshot.data}!",
                        style: TextStyle(
                          fontFamily: Styles.fontFamily,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w500,
                          fontSize: 24,
                        ),
                      );
                    },
                    future: username,
                  ),
                ),
                RateContainerWidget(),
                RateChartSectionWidget(),
                ArticlesSectionWidget(
                  viewmodel: context.read(),
                ),
                SizedBox(
                  height: 32,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
