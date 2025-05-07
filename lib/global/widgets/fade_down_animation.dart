import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class FadeDownAnimation extends StatelessWidget {
  final Widget child;
  final double? from;
  final int delayMilliSeconds;
  final int duration;
  const FadeDownAnimation(
      {Key? key,
      required this.child,
      this.from,
      required this.delayMilliSeconds,
      required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
        from: from ?? 10,
        delay: Duration(milliseconds: delayMilliSeconds),
        duration: Duration(milliseconds: duration),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 1500),
          opacity: 1,
          child: child,
        ));
  }
}
