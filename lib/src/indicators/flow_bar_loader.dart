import 'package:flutter/material.dart';

class FlowBarLoader extends StatefulWidget {
  final Color color;
  final double size;

  const FlowBarLoader({
    Key? key, 
    this.color = Colors.white,
    this.size = 40,
  }) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<FlowBarLoader> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 700),
        vsync: this,
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
          reverseCurve: Curves.easeInOut,
        ),
      );
    }).toList();

    // Stagger the animations
    Future.delayed(Duration.zero, () {
      _controllers[0].repeat(reverse: true);
      Future.delayed(const Duration(milliseconds: 250), () {
        _controllers[1].repeat(reverse: true);
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        _controllers[2].repeat(reverse: true);
      });
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: CustomPaint(
          painter: LoaderPainter(_animations, widget.color),
        ),
      ),
    );
  }
}

class LoaderPainter extends CustomPainter {
  final List<Animation<double>> animations;
  final Color color;

  LoaderPainter(this.animations, this.color) : super(repaint: Listenable.merge(animations));

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final barWidth = size.width / 5;
    final space = size.width / 5;
    final maxHeight = size.height / 2;  // Half of the total height
    final centerY = size.height / 2;

    for (var i = 0; i < 3; i++) {
      final left = i * (barWidth + space);
      final height = maxHeight * animations[i].value;
      final top = centerY - height;
      final bottom = centerY + height;

      // Draw the center-growing bar
      canvas.drawRect(
        Rect.fromLTRB(left, top, left + barWidth, bottom),
        paint,
      );

      // Draw top cap
      canvas.drawOval(
        Rect.fromLTRB(left, top - barWidth / 2, left + barWidth, top + barWidth / 2),
        paint,
      );

      // Draw bottom cap
      canvas.drawOval(
        Rect.fromLTRB(left, bottom - barWidth / 2, left + barWidth, bottom + barWidth / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant LoaderPainter oldDelegate) => true;
} 