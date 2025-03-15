import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class RateSliderItemWidget extends StatelessWidget {
  final String label;
  final int id;
  final bool? active;
  final Function(int idx) callback;
  final Color activeColor;
  const RateSliderItemWidget({
    super.key,
    required this.label,
    required this.id,
    required this.callback,
    this.active,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: GestureDetector(
        onTap: () => {callback(id)},
        child: Container(
          decoration: BoxDecoration(
            color: active == true ? activeColor : Colors.transparent,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: active == true ? Colors.white : Styles.fontColorDark,
                fontSize: 12,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
