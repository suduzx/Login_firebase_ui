import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_loginui/config/Palette.dart';
import 'package:flutter/animation.dart';

class BackgroundPainter extends CustomPainter {
  BackgroundPainter({Animation<double> animation})
      : bluePaint = Paint()
          ..color = Palette.lightBlue
          ..style = PaintingStyle.fill,
        greyPaint = Paint()
          ..color = Palette.darkBlue
          ..style = PaintingStyle.fill,
        orangePaint = Paint()
          ..color = Palette.orange
          ..style = PaintingStyle.fill,
        liquidAnim = CurvedAnimation(
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
          parent: animation,
        ),
        orangeAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.7,
            curve: Interval(0, 0.9, curve: SpringCurve()),
          ),
          reverseCurve: Curves.linear,
        ),
        greyAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.8,
            curve: Interval(0, 0.9, curve: SpringCurve()),
          ),
          reverseCurve: Curves.easeInCirc,
        ),
        blueAnim = CurvedAnimation(
          parent: animation,
          curve: const SpringCurve(),
          reverseCurve: Curves.easeInCirc,
        ),
        super(repaint: animation);

  final Animation<double> liquidAnim;
  final Animation<double> blueAnim;
  final Animation<double> greyAnim;
  final Animation<double> orangeAnim;
  final Paint bluePaint;
  final Paint greyPaint;
  final Paint orangePaint;
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    print('painting');
    paintBlue(canvas, size);
    //canvas.drawPaint(Paint()..color = Palette.darkBlue);
    painGrey(canvas, size);
    painOrange(canvas, size);
  }

  void paintBlue(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, lerpDouble(0, size.height, blueAnim.value));
    //path.quadraticBezierTo(size.width/2, 0, size.width, size.height/2);
    _addPointstoPath(path, [
      Point(lerpDouble(0, size.width / 3, blueAnim.value),
          lerpDouble(0, size.height, blueAnim.value)),
      //Point(size.width/2, size.height/2),
      Point(lerpDouble(size.width / 2, size.width / 4 * 3, blueAnim.value),
          lerpDouble(size.height / 2, size.height / 4 * 3, blueAnim.value)),
      Point(size.width, size.height / 2)
    ]);
    canvas.drawPath(path, bluePaint);
  }

  void painGrey(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
        0,
        lerpDouble(
          size.height / 4,
          size.height / 2,
          greyAnim.value,
        ));
    _addPointstoPath(path, [
      Point(size.width / 4,
          lerpDouble(size.height / 2, size.height * 3 / 4, liquidAnim.value)),
      //Point(size.width/2, size.height/2),
      Point(
        size.width * 3 / 5,
        lerpDouble(size.height / 4, size.height / 2, liquidAnim.value),
      ),
      Point(size.width * 4 / 5,
          lerpDouble(size.height / 6, size.height / 3, greyAnim.value)),
      Point(
        size.width,
        lerpDouble(size.height / 5, size.height / 4, greyAnim.value),
      ),
    ]);
    canvas.drawPath(path, greyPaint);
  }
  void painOrange(Canvas canvas, Size size){
    if(orangeAnim.value > 0){
    final path = Path();
    path.moveTo(size.width * 3 / 4, 0);
    path.lineTo(0, 0);
    path.lineTo(0,
      lerpDouble(0, size.height / 12, orangeAnim.value));
    _addPointstoPath(path, [
      Point(
        size.width / 7,
        lerpDouble(0, size.height / 6, liquidAnim.value),
      ),
      Point(
        size.width / 3,
        lerpDouble(0, size.height / 10, liquidAnim.value),
      ),
      Point(
        size.width / 3 * 2,
        lerpDouble(0, size.height / 8, liquidAnim.value),
      ),
      Point(
        size.width * 3 / 4, 0)

    ]);
    canvas.drawPath( path, orangePaint);
  }}
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  void _addPointstoPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('need three 3 or more point to create a path');
    }
    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }
    // connect the last two point
    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 2].y);
  }
}

class Point {
  final double x, y;
  Point(this.x, this.y);
}

// custom
class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 18.3,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}
