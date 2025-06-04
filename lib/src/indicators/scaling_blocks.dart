import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// A loading indicator that shows three blocks scaling up and down in sequence.
///
/// The blocks animate with a wave-like effect, creating a smooth and engaging loading animation.
/// The blocks' color and size can be customized.
class ScalingBlocksIndicator extends StatefulWidget {
  /// The color of the blocks.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a scaling blocks indicator.
  ///
  /// The [color] and [size] parameters are required.
  const ScalingBlocksIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<ScalingBlocksIndicator> createState() => _ScalingBlocksIndicatorState();
}

class _ScalingBlocksIndicatorState extends State<ScalingBlocksIndicator>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      ),
    );
    
    _animations = _controllers.map((controller) {
      return Tween(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    // Start animations with delay
    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final blockSize = widget.size / 5;
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (i) {
            return AnimatedBuilder(
              animation: _controllers[i],
              builder: (_, __) => Transform.scale(
                scale: _animations[i].value,
                child: Container(
                  width: blockSize,
                  height: blockSize,
                  decoration: BoxDecoration(
                    color: widget.color,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
} 