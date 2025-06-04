import 'package:flutter/material.dart';
import 'dart:math' as math;

class PulseOrbitLoader extends StatefulWidget {
  final Color color;
  final double size;

  const PulseOrbitLoader({
    Key? key, 
    this.color = Colors.white,
    this.size = 40,
  }) : super(key: key);

  @override
  _LoaderAnimationState createState() => _LoaderAnimationState();
}

class _LoaderAnimationState extends State<PulseOrbitLoader> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: _LoaderPainter(
                animation: _controller,
                color: widget.color,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoaderPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  _LoaderPainter({required this.animation, required this.color}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Calculate which quarter is currently animating (0-3)
    int currentQuarter = (animation.value * 4).floor();

    for (int i = 0; i < 4; i++) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(i * math.pi / 2);

      if (i == currentQuarter) {
        // Calculate the progress of the current quarter's animation (0-1)
        double quarterProgress = (animation.value * 4) % 1;

        // Move outwards then return (using sine function for smooth movement)
        double offset = math.sin(quarterProgress * math.pi) * (size.width * 0.125); // Adjusted offset based on size

        // Move outwards (positive offset)
        canvas.translate(offset, offset);
      }

      // Draw the quarter
      Path path = Path()
        ..moveTo(0, 0)
        ..lineTo(radius, 0)
        ..arcTo(
          Rect.fromCircle(center: Offset.zero, radius: radius),
          0,
          math.pi / 2,
          false,
        )
        ..lineTo(0, 0);

      canvas.drawPath(path, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 