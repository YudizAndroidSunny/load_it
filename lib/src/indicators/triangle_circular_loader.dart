import 'dart:math';
import 'package:flutter/material.dart';

class TriangleCircularLoader extends StatefulWidget {
  final Color color;
  final double size;

  const TriangleCircularLoader({
    Key? key, 
    this.color = Colors.white,
    this.size = 40,
  }) : super(key: key);

  @override
  _LoaderAnimationState createState() => _LoaderAnimationState();
}

class _LoaderAnimationState extends State<TriangleCircularLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
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
              painter: _LoaderPainter(_controller.value, widget.color),
            ),
          );
        },
      ),
    );
  }
}

class _LoaderPainter extends CustomPainter {
  final double animationValue;
  final Color color;

  _LoaderPainter(this.animationValue, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width * 0.2;
    final dotRadius = size.width * 0.08;

    for (int i = 0; i < 3; i++) {
      final angle = 2 * pi * (animationValue - (i / 3));
      final x = centerX + radius * cos(angle);
      final y = centerY + radius * sin(angle);

      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(_LoaderPainter oldDelegate) => true;
} 