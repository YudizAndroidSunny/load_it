import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// A loading indicator that shows a single bar stretching up and down.
///
/// The bar animates with a smooth stretching effect. The bar's color and size can be customized.
class StretchingBarIndicator extends StatefulWidget {
  /// The color of the bar.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a stretching bar indicator.
  ///
  /// The [color] and [size] parameters are required.
  const StretchingBarIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<StretchingBarIndicator> createState() => _StretchingBarIndicatorState();
}

class _StretchingBarIndicatorState extends State<StretchingBarIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
    _scaleAnim = Tween(begin: 0.4, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnim,
      builder: (_, __) => Align(
        alignment: Alignment.center,
        child: Container(
          width: widget.size / 6,
          height: widget.size * _scaleAnim.value,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(widget.size / 12),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                widget.color,
                widget.color.withOpacity(0.8),
              ],
            ),
          ),
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