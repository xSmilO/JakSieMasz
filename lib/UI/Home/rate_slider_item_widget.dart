import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class RateSliderItemWidget extends StatelessWidget {
  final String label;
  final bool? active;
  const RateSliderItemWidget({super.key, required this.label, this.active});

  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.tight,
        child: Container(
          color: active == true ? Styles.primaryColor500 : Colors.white,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: active == true ? Colors.white : Colors.black,
                fontSize: 12,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ));
  }
}
