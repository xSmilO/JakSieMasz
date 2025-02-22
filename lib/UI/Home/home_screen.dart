import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/UI/Home/rate_container_widget.dart';
import 'package:jak_sie_masz/UI/Shared/widgets/navigation_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Styles.bgColor,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: Color(0xFF24DB82),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 48),
                          child: Text(
                            "Witaj Śmigło!",
                            style: TextStyle(
                              fontFamily: Styles.fontFamily,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        RateContainerWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          NavigationWidget(),
        ],
      ),
    );
  }
}
