import 'package:flutter/material.dart';
import 'package:like_button/src/utils/like_button_model.dart';
import 'package:like_button/src/utils/like_button_util.dart';

///
///  create by zmtzawqlp on 2019/5/27
///

class CirclePainter extends CustomPainter {
  Paint circlePaint = new Paint();
  Paint maskPaint = new Paint();

  final double outerCircleRadiusProgress;
  final double innerCircleRadiusProgress;
  final CircleColor circleColor;

  CirclePainter(
      {@required this.outerCircleRadiusProgress,
      @required this.innerCircleRadiusProgress,
      this.circleColor = const CircleColor(
          start: const Color(0xFFFF5722), end: const Color(0xFFFFC107))}) {
    circlePaint..style = PaintingStyle.fill;
    //maskPaint..blendMode = BlendMode.clear;  crashed flutter_web
  }

  @override
  void paint(Canvas canvas, Size size) {
    double center = size.width * 0.5;
    _updateCircleColor();
    canvas.saveLayer(Offset.zero & size, Paint());
    canvas.drawCircle(Offset(center, center),
        outerCircleRadiusProgress * center, circlePaint);
    canvas.drawCircle(Offset(center, center),
        innerCircleRadiusProgress * center + 1, maskPaint);
    canvas.restore();
  }

  void _updateCircleColor() {
    double colorProgress = clamp(outerCircleRadiusProgress, 0.5, 1.0);
    colorProgress = mapValueFromRangeToRange(colorProgress, 0.5, 1.0, 0.0, 1.0);
    circlePaint
      ..color = Color.lerp(circleColor.start, circleColor.end, colorProgress);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
