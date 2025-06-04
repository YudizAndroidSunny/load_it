import 'package:flutter/material.dart';
import 'dart:math' as math show pi, cos, sin;
import '../utils/constants.dart';

/// A loading indicator that shows a rotating triangle.
///
/// The triangle rotates continuously around its center.
/// The color and size can be customized.
class RotatingTriangleIndicator extends StatefulWidget {
  /// The color of the triangle.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a rotating triangle indicator.
  ///
  /// The [color] and [size] parameters are required.
  const RotatingTriangleIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<RotatingTriangleIndicator> createState() => _RotatingTriangleIndicatorState();
}

class _RotatingTriangleIndicatorState extends State<RotatingTriangleIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: CustomPaint(
            size: Size.square(widget.size),
            painter: _TrianglePainter(
              color: widget.color,
              shadowColor: widget.color.withOpacity(0.3),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  final Color shadowColor;

  _TrianglePainter({required this.color, required this.shadowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = shadowColor
      ..style = PaintingStyle.fill
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw shadow
    path.moveTo(center.dx, center.dy - radius);
    path.lineTo(center.dx + radius * math.cos(math.pi / 6), center.dy + radius * math.sin(math.pi / 6));
    path.lineTo(center.dx - radius * math.cos(math.pi / 6), center.dy + radius * math.sin(math.pi / 6));
    path.close();
    canvas.drawPath(path, shadowPaint);

    // Draw triangle
    path.reset();
    path.moveTo(center.dx, center.dy - radius * 0.9);
    path.lineTo(center.dx + radius * 0.9 * math.cos(math.pi / 6), center.dy + radius * 0.9 * math.sin(math.pi / 6));
    path.lineTo(center.dx - radius * 0.9 * math.cos(math.pi / 6), center.dy + radius * 0.9 * math.sin(math.pi / 6));
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TrianglePainter oldDelegate) =>
      color != oldDelegate.color || shadowColor != oldDelegate.shadowColor;
} 