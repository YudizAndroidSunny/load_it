import 'dart:math';
import 'package:flutter/material.dart';

class LinearDotsWithPause extends StatefulWidget {
  final Color color;
  final double size;

  const LinearDotsWithPause({
    Key? key,
    this.color = Colors.white,
    this.size = 40,
  }) : super(key: key);

  @override
  _AnimatedLoaderState createState() => _AnimatedLoaderState();
}

class _AnimatedLoaderState extends State<LinearDotsWithPause> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500), // 1.5 seconds for animation + pause
    );

    _animation = Tween<double>(begin: 0, end: 4).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0, 0.75, curve: Curves.easeInOut), // Animation happens in first 75% of the cycle
      ),
    );

    _startAnimation();
  }

  void _startAnimation() async {
    while (true) {
      await _controller.forward();
      await Future.delayed(Duration(milliseconds: 500)); // 0.5 second pause
      _controller.reset();
    }
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
        width: widget.size + 5,
        height: widget.size,
        child: CustomPaint(
          painter: _LoaderPainter(
            color: widget.color,
            animation: _animation,
          ),
        ),
      ),
    );
  }
}

class _LoaderPainter extends CustomPainter {
  final Color color;
  final Animation<double> animation;

  _LoaderPainter({required this.color, required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final dotRadius = size.height * 0.1;
    final dotSpacing = size.width / 3;

    for (int i = 0; i < 4; i++) {
      final x = i * dotSpacing;
      double y;
      if (animation.value >= i && animation.value < i + 1) {
        final t = animation.value - i;
        y = size.height / 2 - sin(t * pi) * (size.height * 0.2); // Reduced bounce height
      } else {
        y = size.height / 2;
      }

      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 