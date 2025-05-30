import 'package:flutter/material.dart';

class AnimationHelper {
  static AnimationController createResultAnimationController(TickerProvider vsync) {
    return AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: vsync,
    );
  }

  static Animation<double> createResultScaleAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.elasticOut,
    ));
  }
}