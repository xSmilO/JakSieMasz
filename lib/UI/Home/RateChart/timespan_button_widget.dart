import 'package:flutter/material.dart';
import 'package:jak_sie_masz/Styles/styles.dart';

class TimespanButtonWidget extends StatelessWidget {
  const TimespanButtonWidget({
    super.key,
    required this.id,
    required this.label,
    required this.setId,
    required this.selectedId,
  });
  final int id;
  final int selectedId;
  final String label;
  final Function(int id) setId;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          print("change chart data");
          setId(id);
        },
        style: ButtonStyle(
            alignment: Alignment.center,
            backgroundColor: WidgetStatePropertyAll(selectedId == id
                ? Styles.primaryColor500
                : Styles.primaryColor100),
            padding: WidgetStatePropertyAll(EdgeInsets.zero),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                side: BorderSide(
                  color: Styles.primaryColor500,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            minimumSize: WidgetStatePropertyAll(
              Size(1, 1),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: Styles.fontFamily,
              color: selectedId == id ? Colors.white : Styles.primaryColor500,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ));
  }
}
