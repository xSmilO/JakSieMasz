import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jak_sie_masz/Data/repositories/user_repository.dart';
import 'package:jak_sie_masz/Styles/styles.dart';
import 'package:jak_sie_masz/routing/routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key, required this.userRepository});
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    String username = "";
    return Scaffold(
      backgroundColor: Styles.primaryColor500,
      body: Container(
        color: Styles.primaryColor500,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  Text(
                    "Witaj w aplikacji\nJakSieMasz!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: Styles.fontSizeH1,
                      color: Colors.white,
                      fontFamily: Styles.fontFamily,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      height: 1.5,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16,
                    children: [
                      Text(
                        "Jak chcesz abym się do ciebie zwracał?",
                        style: TextStyle(
                          fontSize: Styles.fontSizeP,
                          color: Colors.white,
                          fontFamily: Styles.fontFamily,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.none,
                          height: 1.5,
                        ),
                      ),
                      Container(
                        child: TextField(
                          onChanged: (value) {
                            username = value;
                          },
                          cursorColor: Styles.primaryColor100,
                          decoration: InputDecoration(
                            hintText: "Nazwa",
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                                borderRadius: BorderRadius.circular(32)),
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(
                              color: Styles.primaryColor300,
                              fontFamily: Styles.fontFamily,
                              fontWeight: FontWeight.normal,
                              fontSize: Styles.fontSizeP,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(32),
                              borderSide: BorderSide(
                                color: Styles.primaryColor300,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: Styles.primaryColor500,
                            fontFamily: Styles.fontFamily,
                            fontWeight: FontWeight.normal,
                            fontSize: Styles.fontSizeP,
                          ),
                        ),
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            userRepository.setUsername(username);
                            userRepository
                                .setAvatarPath("assets/avatars/dog.jpg");

                            context.go(Routes.home);
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Styles.primaryColor100),
                              side: WidgetStatePropertyAll(BorderSide(
                                color: Styles.primaryColor200,
                              ))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 24),
                            child: Text(
                              "Potwierdź",
                              style: TextStyle(color: Styles.primaryColor500),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
