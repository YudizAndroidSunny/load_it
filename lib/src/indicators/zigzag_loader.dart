import 'package:flutter/material.dart';
import 'dart:math' show pi, sin;
import '../utils/constants.dart';

/// A loading indicator that shows dots moving in a zigzag pattern.
///
/// The dots animate in a wave-like zigzag motion. The color and size can be customized.
class ZigzagLoaderIndicator extends StatefulWidget {
  /// The color of the dots.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a zigzag loader indicator.
  ///
  /// The [color] and [size] parameters are required.
  const ZigzagLoaderIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<ZigzagLoaderIndicator> createState() => _ZigzagLoaderIndicatorState();
}

class _ZigzagLoaderIndicatorState extends State<ZigzagLoaderIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700))..repeat();
    _animation = Tween(begin: -1.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    final dotSize = widget.size / 8;
    return SizedBox(
      width: widget.size,
      height: widget.size / 2,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) {
          return Stack(
            children: List.generate(5, (i) {
              double x = i * widget.size / 5;
              double y = sin(_animation.value * pi + i) * widget.size / 8 + widget.size / 4;
              return Positioned(
                left: x,
                top: y,
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: widget.color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withOpacity(0.3),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
} 