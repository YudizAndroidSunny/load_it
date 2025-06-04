import 'package:flutter/material.dart';
import '../utils/constants.dart';

/// A loading indicator that shows dots flipping in sequence.
///
/// The dots flip with a 3D effect, creating an engaging loading animation.
/// The dots' color and size can be customized.
class FlipDotsIndicator extends StatefulWidget {
  /// The color of the dots.
  final Color color;

  /// The size of the indicator.
  final double size;

  /// Creates a flip dots indicator.
  ///
  /// The [color] and [size] parameters are required.
  const FlipDotsIndicator({
    super.key,
    this.color = defaultIndicatorColor,
    this.size = defaultIndicatorSize,
  });

  @override
  State<FlipDotsIndicator> createState() => _FlipDotsIndicatorState();
}

class _FlipDotsIndicatorState extends State<FlipDotsIndicator>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      5,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 1500),
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeInOut,
        ),
      );
    }).toList();

    for (var i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 300), () {
        if (mounted) {
          _controllers[i].repeat();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return AnimatedBuilder(
            animation: _animations[index],
            builder: (_, __) {
              final value = _animations[index].value;
              final isFlipping = value > 0.5;
              final flipValue = isFlipping ? (1 - value) * 2 : value * 2;

              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(flipValue * 3.14159),
                child: Container(
                  width: widget.size / 8,
                  height: widget.size / 8,
                  margin: EdgeInsets.symmetric(horizontal: widget.size / 30),
                  decoration: BoxDecoration(
                    color: isFlipping
                        ? widget.color.withOpacity(0.3)
                        : widget.color,
                    borderRadius: BorderRadius.circular(widget.size / 40),
                    boxShadow: [
                      BoxShadow(
                        color: widget.color.withOpacity(0.3),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
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