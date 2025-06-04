import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// A loading indicator that shows a pulsing circle.
///
/// The circle expands and contracts while fading in and out.
/// The color and size can be customized.
class PulsingCircleIndicator extends StatefulWidget {
  /// The color of the circle.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a pulsing circle indicator.
  ///
  /// The [color] and [size] parameters are required.
  const PulsingCircleIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<PulsingCircleIndicator> createState() => _PulsingCircleIndicatorState();
}

class _PulsingCircleIndicatorState extends State<PulsingCircleIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
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