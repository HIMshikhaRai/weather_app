import 'package:flutter/material.dart';
import 'package:weather_report/models/weather_response.dart';
import 'package:weather_report/views/weather_list_item_widget.dart';

class AnimatedListViewItem extends StatefulWidget {
  final String title;
  final List<ListElement> weatherItemList;
  final int duration;

  const AnimatedListViewItem(this.title, this.weatherItemList, {this.duration = 1,Key? key})
      : super(key: key);

  @override
  _AnimatedListViewItemState createState() => _AnimatedListViewItemState();
}

class _AnimatedListViewItemState extends State<AnimatedListViewItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: WeatherListItemWidget(widget.title, widget.weatherItemList),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
