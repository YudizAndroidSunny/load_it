import 'package:flutter/material.dart';
import 'dart:math' as math show pi;
import '../utils/constants.dart';

/// A loading indicator that shows a rotating square.
///
/// The square rotates continuously around its center.
/// The color and size can be customized.
class RotatingSquareIndicator extends StatefulWidget {
  /// The color of the square.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a rotating square indicator.
  ///
  /// The [color] and [size] parameters are required.
  const RotatingSquareIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<RotatingSquareIndicator> createState() => _RotatingSquareIndicatorState();
}

class _RotatingSquareIndicatorState extends State<RotatingSquareIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this)..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(widget.size / 8),
              boxShadow: [
                BoxShadow(
                  color: widget.color.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
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