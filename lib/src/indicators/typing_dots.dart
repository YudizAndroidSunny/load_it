import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// A loading indicator that shows three dots fading in and out, simulating typing.
///
/// The dots animate in sequence. The color and size can be customized.
class TypingDotsIndicator extends StatefulWidget {
  /// The color of the dots.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a typing dots indicator.
  ///
  /// The [color] and [size] parameters are required.
  const TypingDotsIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<TypingDotsIndicator> createState() => _TypingDotsIndicatorState();
}

class _TypingDotsIndicatorState extends State<TypingDotsIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 1000), vsync: this)..repeat();
    _animations = [0.0, 0.2, 0.4].map((start) {
      return Tween(begin: 0.3, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(start, start + 0.5, curve: Curves.easeInOut),
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double dotSize = widget.size / 5;
    return SizedBox(
      width: widget.size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _animations.map((anim) {
          return AnimatedBuilder(
            animation: anim,
            builder: (_, __) => Opacity(
              opacity: anim.value,
              child: Container(
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  color: widget.color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
} 