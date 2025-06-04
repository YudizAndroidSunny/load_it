import 'package:flutter/material.dart';

class GridPulseLoader extends StatefulWidget {
  final Color color;
  final double size;

  const GridPulseLoader({
    Key? key, 
    this.color = Colors.white,
    this.size = 40,
  }) : super(key: key);

  @override
  _LoaderAnimationState createState() => _LoaderAnimationState();
}

class _LoaderAnimationState extends State<GridPulseLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: PauseAtOriginalPositionCurve(),
    );
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
        animation: _animation,
        builder: (context, child) {
          return SizedBox(
            width: widget.size,
            height: widget.size,
            child: CustomPaint(
              painter: _LoaderPainter(_animation.value, widget.color),
            ),
          );
        },
      ),
    );
  }
}

class PauseAtOriginalPositionCurve extends Curve {
  @override
  double transform(double t) {
    if (t < 0.4) {
      // Outward movement (40% of the time)
      return Curves.easeOut.transform(t / 0.4);
    } else if (t < 0.6) {
      // Inward movement (20% of the time)
      return 1.0 - Curves.easeIn.transform((t - 0.4) / 0.2);
    } else {
      // Pause at the original position (40% of the time)
      return 0.0;
    }
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

    final squareSize = size.width / 3;
    final maxOffset = squareSize * 0.4;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        double dx = 0;
        double dy = 0;

        // Apply animation only to outer squares
        if (i != 1 || j != 1) {
          dx = i == 0 ? -maxOffset * animationValue : (i == 2 ? maxOffset * animationValue : 0);
          dy = j == 0 ? -maxOffset * animationValue : (j == 2 ? maxOffset * animationValue : 0);
        }

        canvas.drawRect(
          Rect.fromLTWH(
            i * squareSize + dx,
            j * squareSize + dy,
            squareSize,
            squareSize,
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
} 