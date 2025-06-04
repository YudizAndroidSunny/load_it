import 'package:flutter/material.dart';
import '../widgets/dot_widget.dart';
import '../utils/constants.dart';

/// A loading indicator that shows three dots bouncing up and down in sequence.
///
/// The dots bounce with a slight delay between each dot, creating a wave-like
/// animation effect. Each dot is customizable in terms of color and size.
class BouncingDotsIndicator extends StatefulWidget {
  /// The color of the dots.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a bouncing dots indicator.
  ///
  /// The [color] and [size] parameters are required.
  const BouncingDotsIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<BouncingDotsIndicator> createState() => _BouncingDotsIndicatorState();
}

class _BouncingDotsIndicatorState extends State<BouncingDotsIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: defaultAnimationDuration,
    )..repeat();

    _animations = [0.0, 0.2, 0.4].map((start) {
      return TweenSequence([
        TweenSequenceItem(tween: Tween(begin: 0.0, end: -10.0), weight: 50),
        TweenSequenceItem(tween: Tween(begin: -10.0, end: 0.0), weight: 50),
      ]).animate(CurvedAnimation(
        parent: _controller,
        curve: Interval(start, start + 0.6),
      ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final dotSize = widget.size / 5;
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _animations.map((anim) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (_, __) => Transform.translate(
              offset: Offset(0, anim.value),
              child: Dot(color: widget.color, size: dotSize),
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