import 'package:flutter/material.dart';

class CustomTabUnderlineIndicator extends Decoration {
  CustomTabUnderlineIndicator({required Color color, required double radius})
      : _painter = _UnderlinePainter(color, radius);

  final _UnderlinePainter _painter;
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _UnderlinePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _UnderlinePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    var r = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          offset.dx,
          offset.dy + configuration.size!.height,
          configuration.size!.width,
          3.5,
        ),
        Radius.circular(radius));
    canvas.drawRRect(r, _paint);
  }
}
