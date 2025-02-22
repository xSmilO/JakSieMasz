import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmojisContainerWidget extends StatelessWidget {
  const EmojisContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          "assets/emoji_slightly_frowning_face.svg",
          width: 32,
          fit: BoxFit.fill,
        ),
        SvgPicture.asset(
          "assets/emoji_slightly_smiling_face.svg",
          width: 32,
          fit: BoxFit.fill,
        ),
        SvgPicture.asset(
          "assets/emoji_star_struck.svg",
          width: 32,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
