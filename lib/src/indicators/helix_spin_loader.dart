import 'package:flutter/material.dart';
import 'dart:math' as math;

class HelixSpinLoader extends StatefulWidget {
  final double size;
  final Color color;

  const HelixSpinLoader({
    Key? key,
    this.size = 40,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  _LoaderAnimationState createState() => _LoaderAnimationState();
}

class _LoaderAnimationState extends State<HelixSpinLoader> with SingleTickerProviderStateMixin {
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
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return SizedBox(
            width: widget.size,
            height: widget.size,
            child: CustomPaint(
              painter: _LoaderPainter(
                animation: _controller,
                color: widget.color,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LoaderPainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  _LoaderPainter({required this.animation, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final progress = animation.value;

    if (progress < 0.25) {
      // Step 1: Full circle
      canvas.drawCircle(center, radius, paint);
    } else {
      for (int i = 0; i < 3; i++) {
        final startAngle = i * 2 * math.pi / 3;
        final sweepAngle = 2 * math.pi / 3;

        canvas.save();
        canvas.translate(center.dx, center.dy);

        if (progress < 0.5) {
          // Step 2: Divide and move backwards
          double moveBack = (progress - 0.25) * 4 * (size.width / 5);
          canvas.translate(moveBack * math.cos(startAngle + math.pi / 3), moveBack * math.sin(startAngle + math.pi / 3));
        } else if (progress < 0.75) {
          // Step 3: Rotate 360 degrees while keeping the moved-back position
          double moveBack = size.width / 5;
          canvas.translate(moveBack * math.cos(startAngle + math.pi / 3), moveBack * math.sin(startAngle + math.pi / 3));
          double rotation = (progress - 0.5) * 4 * 2 * math.pi;
          canvas.rotate(rotation);
        } else {
          // Step 4: Move back to original position
          double moveBack = (1 - progress) * 4 * (size.width / 5);
          canvas.translate(moveBack * math.cos(startAngle + math.pi / 3), moveBack * math.sin(startAngle + math.pi / 3));
        }

        canvas.translate(-center.dx, -center.dy);

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle,
          true,
          paint,
        );

        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 