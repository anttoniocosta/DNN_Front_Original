import 'package:flutter/material.dart';

class DottedLine extends StatelessWidget {
  final double height;
  final Color color;
  final double dotSize;
  final double spacing;

  const DottedLine({
    super.key,
    this.height = 1.0,
    this.color = Colors.black,
    this.dotSize = 4.0,
    this.spacing = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedLinePainter(
        color: color,
        dotSize: dotSize,
        spacing: spacing,
      ),
      child: SizedBox(
        height: height,
      ),
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double dotSize;
  final double spacing;

  _DottedLinePainter({
    required this.color,
    required this.dotSize,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round;

    final dashWidth = dotSize;
    final dashSpace = spacing;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DottedLinePainter oldDelegate) {
    return color != oldDelegate.color ||
        dotSize != oldDelegate.dotSize ||
        spacing != oldDelegate.spacing;
  }
}
