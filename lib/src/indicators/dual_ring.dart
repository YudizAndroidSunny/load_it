import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// A loading indicator that shows two concentric rings rotating in opposite directions.
///
/// The outer and inner rings rotate in opposite directions, creating an engaging
/// visual effect. The rings' color and size can be customized.
class DualRingIndicator extends StatefulWidget {
  /// The color of the rings.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a dual ring indicator.
  ///
  /// The [color] and [size] parameters are required.
  const DualRingIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<DualRingIndicator> createState() => _DualRingIndicatorState();
}

class _DualRingIndicatorState extends State<DualRingIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _outerAnimation;
  late final Animation<double> _innerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _outerAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.1416,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _innerAnimation = Tween<double>(
      begin: 0,
      end: -2 * 3.1416,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => Stack(
          alignment: Alignment.center,
          children: [
            Transform.rotate(
              angle: _outerAnimation.value,
              child: SizedBox(
                width: widget.size,
                height: widget.size,
                child: CircularProgressIndicator(
                  strokeWidth: defaultStrokeWidth,
                  valueColor: AlwaysStoppedAnimation(widget.color),
                ),
              ),
            ),
            Transform.rotate(
              angle: _innerAnimation.value,
              child: SizedBox(
                width: widget.size / 2,
                height: widget.size / 2,
                child: CircularProgressIndicator(
                  strokeWidth: defaultStrokeWidth,
                  valueColor: AlwaysStoppedAnimation(widget.color.withOpacity(0.6)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
} 