import 'package:flutter/material.dart';
import 'dart:math' as math show pi, cos, sin;
import '../utils/constants.dart';

/// A loading indicator that shows a pulsing hexagon.
///
/// The hexagon expands and contracts while rotating.
/// The color and size can be customized.
class HexagonPulseIndicator extends StatefulWidget {
  /// The color of the hexagon.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a hexagon pulse indicator.
  ///
  /// The [color] and [size] parameters are required.
  const HexagonPulseIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<HexagonPulseIndicator> createState() => _HexagonPulseIndicatorState();
}

class _HexagonPulseIndicatorState extends State<HexagonPulseIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.rotate(
          angle: _rotateAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: CustomPaint(
              size: Size.square(widget.size),
              painter: _HexagonPainter(
                color: widget.color,
                shadowColor: widget.color.withOpacity(0.3),
              ),
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

class _HexagonPainter extends CustomPainter {
  final Color color;
  final Color shadowColor;

  _HexagonPainter({required this.color, required this.shadowColor});

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
    for (var i = 0; i < 6; i++) {
      final angle = i * math.pi / 3;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, shadowPaint);

    // Draw hexagon
    path.reset();
    for (var i = 0; i < 6; i++) {
      final angle = i * math.pi / 3;
      final x = center.dx + radius * 0.9 * math.cos(angle);
      final y = center.dy + radius * 0.9 * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_HexagonPainter oldDelegate) =>
      color != oldDelegate.color || shadowColor != oldDelegate.shadowColor;
} 