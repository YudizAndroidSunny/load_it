import 'package:flutter/material.dart';
import 'dart:math' show pi, sin, cos;
import '../utils/constants.dart';

/// A loading indicator that shows dots spinning in a vortex pattern.
///
/// The dots animate in a circular vortex. The color and size can be customized.
class VortexSpinnerIndicator extends StatefulWidget {
  /// The color of the dots.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a vortex spinner indicator.
  ///
  /// The [color] and [size] parameters are required.
  const VortexSpinnerIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<VortexSpinnerIndicator> createState() => _VortexSpinnerIndicatorState();
}

class _VortexSpinnerIndicatorState extends State<VortexSpinnerIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final dotCount = 8;
    final radius = widget.size / 2.2;
    final dotSize = widget.size / 6;
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Stack(
            alignment: Alignment.center,
            children: List.generate(dotCount, (i) {
              final angle = (2 * pi / dotCount) * i + _controller.value * 2 * pi;
              final dx = cos(angle) * radius;
              final dy = sin(angle) * radius;
              return Positioned(
                left: widget.size / 2 + dx - dotSize / 2,
                top: widget.size / 2 + dy - dotSize / 2,
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.7),
                    shape: BoxShape.circle,
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