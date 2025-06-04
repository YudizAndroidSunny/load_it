import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// A loading indicator that shows a spinning arc.
///
/// The arc spins around its center. The color and size can be customized.
class SpinningArcIndicator extends StatefulWidget {
  /// The color of the arc.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a spinning arc indicator.
  ///
  /// The [color] and [size] parameters are required.
  const SpinningArcIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<SpinningArcIndicator> createState() => _SpinningArcIndicatorState();
}

class _SpinningArcIndicatorState extends State<SpinningArcIndicator>
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
      builder: (_, __) => Transform.rotate(
        angle: _controller.value * 2 * 3.1416,
        child: CustomPaint(
          size: Size.square(widget.size),
          painter: _ArcPainter(color: widget.color),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ArcPainter extends CustomPainter {
  final Color color;
  _ArcPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;
    final rect = Offset.zero & size;
    canvas.drawArc(rect, 0, 3.14 * 1.5, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
} 