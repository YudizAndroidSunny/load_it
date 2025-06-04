import 'package:flutter/material.dart';
import 'dart:math' as math show pi, cos, sin;
import '../utils/constants.dart';

/// A loading indicator that shows a dot orbiting around a center point.
///
/// The dot moves in a circular orbit while rotating around its own axis.
/// The color and size can be customized.
class OrbitLoaderIndicator extends StatefulWidget {
  /// The color of the orbiting dot.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates an orbit loader indicator.
  ///
  /// The [color] and [size] parameters are required.
  const OrbitLoaderIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<OrbitLoaderIndicator> createState() => _OrbitLoaderIndicatorState();
}

class _OrbitLoaderIndicatorState extends State<OrbitLoaderIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 2), vsync: this)..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final orbitAngle = _controller.value * 2 * math.pi;
        final dotSize = widget.size / 6;
        final orbitRadius = widget.size / 3;

        return Stack(
          alignment: Alignment.center,
          children: [
            // Center dot
            Container(
              width: dotSize,
              height: dotSize,
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
            // Orbiting dot
            Transform.translate(
              offset: Offset(
                orbitRadius * math.cos(orbitAngle),
                orbitRadius * math.sin(orbitAngle),
              ),
              child: Transform.rotate(
                angle: orbitAngle,
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
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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