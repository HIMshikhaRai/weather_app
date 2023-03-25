import 'package:flutter/material.dart';

class TextSlideAnimation extends StatefulWidget {
  final Widget textWidget;
  final int duration;
  final bool slideFrmBottom;

  TextSlideAnimation(
      {required this.textWidget,
      this.duration = 1,
      this.slideFrmBottom = false});

  @override
  _TextSlideAnimationState createState() => _TextSlideAnimationState();
}

class _TextSlideAnimationState extends State<TextSlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    );
    _animation = Tween<Offset>(
            begin: widget.slideFrmBottom ? Offset(0, 1) : Offset(1, 0),
            end: Offset(0, 0))
        .animate(_animationController);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.textWidget,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
