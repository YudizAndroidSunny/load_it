import 'package:flutter/material.dart';
import 'dart:math' show pi;
import '../utils/constants.dart';

/// A loading indicator that shows a rotating cube.
///
/// The cube rotates smoothly in 3D space, creating a dynamic and engaging loading effect.
/// The cube's color and size can be customized.
class CubeSpinnerIndicator extends StatefulWidget {
  /// The color of the cube.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a cube spinner indicator.
  ///
  /// The [color] and [size] parameters are required.
  const CubeSpinnerIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<CubeSpinnerIndicator> createState() => _CubeSpinnerIndicatorState();
}

class _CubeSpinnerIndicatorState extends State<CubeSpinnerIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateX(_controller.value * pi)
              ..rotateY(_controller.value * pi),
            child: Container(
              width: widget.size / 2,
              height: widget.size / 2,
              decoration: BoxDecoration(
                color: widget.color,
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
            ),
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