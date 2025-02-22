import 'package:flutter/material.dart';
import 'package:jak_sie_masz/UI/Home/rate_slider_item_widget.dart';
import 'package:jak_sie_masz/UI/Home/viewmodels/rate_slider_viewmodel.dart';
import 'package:provider/provider.dart';

class RateSliderWidget extends StatelessWidget {
  const RateSliderWidget({super.key, required this.viewModel});

  final RateSliderViewmodel viewModel;

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
          child: Consumer<RateSliderViewmodel>(
            builder: (context, slider, child) {
              return Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RateSliderItemWidget(
                    id: 0,
                    label: "1",
                    callback: slider.setCurrentIndex,
                    active: slider.currentIndex == 0,
                  ),
                  RateSliderItemWidget(
                    label: "2",
                    callback: slider.setCurrentIndex,
                    active: slider.currentIndex == 1,
                    id: 1,
                  ),
                  RateSliderItemWidget(
                    label: "3",
                    callback: slider.setCurrentIndex,
                    active: slider.currentIndex == 2,
                    id: 2,
                  ),
                  RateSliderItemWidget(
                    label: "4",
                    callback: slider.setCurrentIndex,
                    active: slider.currentIndex == 3,
                    id: 3,
                  ),
                  RateSliderItemWidget(
                    label: "5",
                    callback: slider.setCurrentIndex,
                    active: slider.currentIndex == 4,
                    id: 4,
                  ),
                  RateSliderItemWidget(
                    label: "6",
                    callback: slider.setCurrentIndex,
                    active: slider.currentIndex == 5,
                    id: 5,
                  ),
                  RateSliderItemWidget(
                    label: "7",
                    callback: slider.setCurrentIndex,
                    active: slider.currentIndex == 6,
                    id: 6,
                  ),
                  RateSliderItemWidget(
                    label: "8",
                    id: 7,
                    callback: slider.setCurrentIndex,
                    active: slider.currentIndex == 7,
                  ),
                  RateSliderItemWidget(
                    label: "9",
                    callback: slider.setCurrentIndex,
                    active: slider.currentIndex == 8,
                    id: 8,
                  ),
                  RateSliderItemWidget(
                    label: "10",
                    callback: slider.setCurrentIndex,
                    active: slider.currentIndex == 9,
                    id: 9,
                  ),
                ],
              );
            },
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
