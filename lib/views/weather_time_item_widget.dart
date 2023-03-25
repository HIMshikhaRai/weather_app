import 'package:flutter/material.dart';
import 'package:weather_report/models/weather_response.dart';
import 'package:weather_report/utils/custom_date_utils.dart';
import 'package:weather_report/utils/suitable_icon.dart';
import 'package:weather_report/views/animation/text_slide_animation.dart';

class WeatherTimeItemWidget extends StatelessWidget {
  final ListElement weatherItem;

  const WeatherTimeItemWidget(this.weatherItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xff5927e5).withOpacity(0.60)),
      child: Column(
        children: [
          TextSlideAnimation(
            textWidget: Text(
              CustomDateUtils().getTime(weatherItem.dtTxt!),
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Colors.white),
            ),
            slideFrmBottom: true,
          ),
          const Spacer(),
          Image.asset(
            SuitableIcon().getIcon(
                weatherItem.weather?.first.description ?? Description.clearSky),
            height: 48,
            width: 48,
          ),
          const SizedBox(
            height: 16,
          ),
          TextSlideAnimation(
            textWidget: Text(
              "${weatherItem.weather?.first.main}",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Colors.white),
            ),
            slideFrmBottom: true,
          ),
        ],
      ),
    );
  }
}
