import 'package:flutter/material.dart';
import 'dart:math';
import '../utils/constants.dart';

/// A loading indicator that shows animated water bubbles rising.
///
/// The bubbles animate upwards, simulating water bubbles. The color and size can be customized.
class WaterBubblesIndicator extends StatefulWidget {
  /// The color of the bubbles.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a water bubbles indicator.
  ///
  /// The [color] and [size] parameters are required.
  const WaterBubblesIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<WaterBubblesIndicator> createState() => _WaterBubblesIndicatorState();
}

class _WaterBubblesIndicatorState extends State<WaterBubblesIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final List<_Bubble> _bubbles = [];

  @override
  void initState() {
    super.initState();
    final rand = Random();
    for (int i = 0; i < 30; i++) {
      _bubbles.add(_Bubble(
        x: rand.nextDouble(),
        y: rand.nextDouble(),
        size: rand.nextDouble() * 0.05 + 0.02,
        speed: rand.nextDouble() * 0.005 + 0.002,
        alpha: rand.nextDouble() * 0.5 + 0.2,
      ));
    }
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => CustomPaint(
        painter: _BubblePainter(_bubbles, widget.color, _controller.value),
        size: Size.square(widget.size),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _Bubble {
  double x;
  double y;
  final double size;
  final double speed;
  final double alpha;

  _Bubble({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.alpha,
  });

  void update(double progress) {
    y -= speed;
    if (y < -0.1) {
      y = 1.1;
    }
  }
}

class _BubblePainter extends CustomPainter {
  final List<_Bubble> bubbles;
  final Color color;
  final double progress;

  _BubblePainter(this.bubbles, this.color, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (final bubble in bubbles) {
      bubble.update(progress);
      paint.color = color.withOpacity(bubble.alpha);
      canvas.drawCircle(
        Offset(bubble.x * size.width, bubble.y * size.height),
        bubble.size * size.width,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_BubblePainter oldDelegate) => true;
} 