import 'package:flutter/material.dart';
import 'dart:math' as math;

class TwistTriangleLoader extends StatefulWidget {
  final Color color;
  final double size;

  const TwistTriangleLoader({
    Key? key, 
    this.color = Colors.white,
    this.size = 40,
  }) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<TwistTriangleLoader> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
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
            return Stack(
              children: [
                _buildTriangle(true),  // Right to left
                _buildTriangle(false), // Top to bottom
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTriangle(bool isRightToLeft) {
    return Transform.rotate(
      angle: _calculateRotation(_controller.value, isRightToLeft),
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: TrianglePainter(color: widget.color),
      ),
    );
  }

  double _calculateRotation(double value, bool isRightToLeft) {
    double rotation;
    if (isRightToLeft) {
      // Right to left rotation
      if (value < 0.125) {
        rotation = 0;
      } else if (value < 0.375) {
        rotation = math.pi * (value - 0.125) / 0.25;
      } else if (value < 0.625) {
        rotation = math.pi;
      } else if (value < 0.875) {
        rotation = math.pi * (1 + (value - 0.625) / 0.25);
      } else {
        rotation = 2 * math.pi;
      }
    } else {
      // Top to bottom rotation (90 degrees offset)
      value = (value + 0.25) % 1;
      if (value < 0.125) {
        rotation = 0;
      } else if (value < 0.375) {
        rotation = math.pi * (value - 0.125) / 0.25;
      } else if (value < 0.625) {
        rotation = math.pi;
      } else if (value < 0.875) {
        rotation = math.pi * (1 + (value - 0.625) / 0.25);
      } else {
        rotation = 2 * math.pi;
      }
      rotation += math.pi / 2; // 90 degrees offset
    }
    return rotation;
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height / 2)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
} 