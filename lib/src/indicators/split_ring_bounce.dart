import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// A loading indicator that shows a split ring bouncing and rotating.
///
/// The ring splits into two parts, bounces and rotates simultaneously.
/// The color and size can be customized.
class SplitRingBounceIndicator extends StatefulWidget {
  /// The color of the ring.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a split ring bounce indicator.
  ///
  /// The [color] and [size] parameters are required.
  const SplitRingBounceIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<SplitRingBounceIndicator> createState() => _SplitRingBounceIndicatorState();
}

class _SplitRingBounceIndicatorState extends State<SplitRingBounceIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value * 2 * 3.14159,
            child: Stack(
              alignment: Alignment.center,
              children: [
                _renderOuterRing(),
                _renderInnerRing(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _renderOuterRing() {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CircularProgressIndicator(
        strokeWidth: defaultStrokeWidth,
        valueColor: AlwaysStoppedAnimation(widget.color),
      ),
    );
  }

  Widget _renderInnerRing() {
    return SizedBox(
      width: widget.size * 0.6,
      height: widget.size * 0.6,
      child: CircularProgressIndicator(
        strokeWidth: defaultStrokeWidth,
        valueColor: AlwaysStoppedAnimation(widget.color.withOpacity(0.6)),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
} 