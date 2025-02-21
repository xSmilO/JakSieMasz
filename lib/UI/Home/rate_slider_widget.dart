import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Home/rate_slider_item_widget.dart';

class RateSliderWidget extends StatelessWidget {
  const RateSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        Container(
          key: Key("rate slider"),
          height: 32,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x18000000),
                  offset: Offset(0, 0),
                  blurRadius: 4,
                  spreadRadius: 1,
                ),
              ]),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              RateSliderItemWidget(
                label: "1",
                active: true,
              ),
              RateSliderItemWidget(
                label: "2",
              ),
              RateSliderItemWidget(
                label: "3",
              ),
              RateSliderItemWidget(
                label: "4",
              ),
              RateSliderItemWidget(
                label: "5",
              ),
              RateSliderItemWidget(
                label: "6",
              ),
              RateSliderItemWidget(
                label: "7",
              ),
              RateSliderItemWidget(
                label: "8",
              ),
              RateSliderItemWidget(
                label: "9",
              ),
              RateSliderItemWidget(
                label: "10",
              ),
            ],
          ),
        ),
        Text(
          "Emojis",
          style: TextStyle(fontSize: 8, color: Colors.black),
        ),
      ],
    );
  }
}
