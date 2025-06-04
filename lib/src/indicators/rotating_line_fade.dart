import 'package:flutter/material.dart';
import 'dart:math' as math show pi, sin;
import '../utils/constants.dart';

/// A loading indicator that shows a rotating line with fading opacity.
///
/// The line rotates continuously while fading in and out.
/// The color and size can be customized.
class RotatingLineFadeIndicator extends StatefulWidget {
  /// The color of the line.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a rotating line fade indicator.
  ///
  /// The [color] and [size] parameters are required.
  const RotatingLineFadeIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<RotatingLineFadeIndicator> createState() => _RotatingLineFadeIndicatorState();
}

class _RotatingLineFadeIndicatorState extends State<RotatingLineFadeIndicator>
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
          child: Opacity(
            opacity: (math.sin(_controller.value * 4 * math.pi) + 1) / 2,
            child: Container(
              width: widget.size,
              height: widget.size / 8,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(widget.size / 16),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
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