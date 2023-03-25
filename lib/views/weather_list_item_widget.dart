import 'package:flutter/material.dart';
import 'package:weather_report/models/weather_response.dart';
import 'package:weather_report/utils/custom_date_utils.dart';
import 'package:weather_report/utils/suitable_icon.dart';
import 'package:weather_report/views/weather_time_item_widget.dart';

class WeatherListItemWidget extends StatelessWidget {
  final String title;
  final List<ListElement> weatherItemList;

  const WeatherListItemWidget(this.title, this.weatherItemList, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (weatherItemList.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: const Color(0xff5927e5).withOpacity(0.60),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                      text:
                          "${CustomDateUtils().getDate(weatherItemList.first.dtTxt!)}\n",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(color: Colors.white),
                      children: [
                        TextSpan(
                          text: title,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white),
                        )
                      ]),
                ),
                Image.asset(
                  SuitableIcon().getIcon(
                      weatherItemList.first.weather?.first.description ??
                          Description.clearSky),
                  height: 64,
                  width: 64,
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${weatherItemList.first.weather?.first.main}",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: Colors.white),
                ),
                Text(
                  "${CustomDateUtils().getTempInCel(weatherItemList.first.main?.temp ?? 32)} °C",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
            _getTimeline(context)
          ],
        ),
      );
    }
    return Container();
  }

  Widget _getTimeline(BuildContext context) {
    if (weatherItemList.length > 1) {
      weatherItemList.removeAt(0);
      return Container(
        height: 150,
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: weatherItemList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext ctx, int index) {
              return WeatherTimeItemWidget(weatherItemList[index]);
            }),
      );
    }
    return Container();
  }
}
