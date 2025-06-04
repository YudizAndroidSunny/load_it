import 'dart:math' show cos, sin, pi;
import 'package:flutter/material.dart';
import 'package:load_it/src/widgets/dot_widget.dart';

class ChasingDotsIndicator extends StatefulWidget {
  final Color color;
  final double size;
  const ChasingDotsIndicator({super.key, required this.color, required this.size});

  @override
  State<ChasingDotsIndicator> createState() => _ChasingDotsIndicatorState();
}

class _ChasingDotsIndicatorState extends State<ChasingDotsIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final radius = widget.size / 3;
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final angle = _controller.value * 2 * pi;
        final dx = radius * cos(angle);
        final dy = radius * sin(angle);
        final dx2 = radius * cos(angle + pi);
        final dy2 = radius * sin(angle + pi);
        
        // Calculate opacity based on animation value
        final opacity1 = 0.5 + (0.5 * sin(_controller.value * 2 * pi));
        final opacity2 = 0.5 + (0.5 * sin(_controller.value * 2 * pi + pi));
        
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: widget.size / 2 + dx - widget.size / 10,
                top: widget.size / 2 + dy - widget.size / 10,
                child: Dot(color: widget.color.withOpacity(opacity1), size: widget.size / 5),
              ),
              Positioned(
                left: widget.size / 2 + dx2 - widget.size / 10,
                top: widget.size / 2 + dy2 - widget.size / 10,
                child: Dot(color: widget.color.withOpacity(opacity2), size: widget.size / 5),
              ),
            ],
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