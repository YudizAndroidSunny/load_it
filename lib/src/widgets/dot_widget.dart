import 'package:flutter/material.dart';

/// A simple dot widget used by various loading indicators.
class Dot extends StatelessWidget {
  /// The color of the dot.
  final Color color;

  /// The size of the dot.
  final double size;

  /// Creates a dot widget.
  const Dot({
    super.key,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
} 