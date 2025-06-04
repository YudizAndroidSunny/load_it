import 'package:flutter/material.dart';
import 'dart:math' show pi, cos, sin;
import '../utils/constants.dart';

/// A loading indicator that mimics a clock with rotating hands.
///
/// The indicator shows a clock face with hour markers and rotating hour and minute hands.
/// The hour hand rotates slowly while the minute hand rotates faster, creating a smooth
/// clock-like animation effect.
class ClockLoaderIndicator extends StatefulWidget {
  /// The color of the clock elements.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a clock loader indicator.
  ///
  /// The [color] and [size] parameters are required.
  const ClockLoaderIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<ClockLoaderIndicator> createState() => _ClockLoaderIndicatorState();
}

class _ClockLoaderIndicatorState extends State<ClockLoaderIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Clock face
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.color.withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.color.withOpacity(0.1),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              // Hour markers
              ...List.generate(12, (i) {
                final angle = i * pi / 6;
                final markerLength = i % 3 == 0 ? widget.size * 0.1 : widget.size * 0.05;
                final markerWidth = i % 3 == 0 ? 3.0 : 2.0;
                final distance = widget.size * 0.4;
                
                return Transform.translate(
                  offset: Offset(
                    cos(angle - pi / 2) * distance,
                    sin(angle - pi / 2) * distance,
                  ),
                  child: Transform.rotate(
                    angle: angle,
                    child: Container(
                      width: markerWidth,
                      height: markerLength,
                      color: widget.color.withOpacity(0.7),
                    ),
                  ),
                );
              }),
              // Hour hand
              Transform.rotate(
                angle: _controller.value * 2 * pi,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 4,
                    height: widget.size * 0.3,
                    decoration: BoxDecoration(
                      color: widget.color.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              // Minute hand
              Transform.rotate(
                angle: _controller.value * 24 * pi,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 3,
                    height: widget.size * 0.4,
                    decoration: BoxDecoration(
                      color: widget.color,
                      borderRadius: BorderRadius.circular(1.5),
                      boxShadow: [
                        BoxShadow(
                          color: widget.color.withOpacity(0.3),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Center dot
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color,
                  boxShadow: [
                    BoxShadow(
                      color: widget.color.withOpacity(0.3),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
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