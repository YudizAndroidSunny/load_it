import 'package:flutter/material.dart';

class TextPulseLoader extends StatefulWidget {
  final double size;
  final Color color;
  final String label;

  const TextPulseLoader({
    super.key,
    this.size = 16.0,
    this.color = Colors.blue,
    this.label = 'Loading',
  });

  @override
  _TextPulseLoaderState createState() => _TextPulseLoaderState();
}

class _TextPulseLoaderState extends State<TextPulseLoader> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _letterAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _letterAnimations = List<Animation<double>>.generate(
      widget.label.length,
      (index) {
        return Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(
              index / widget.label.length,
              (index + 1) / widget.label.length,
              curve: Curves.easeInOut,
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.label.length, (index) {
        String char = widget.label[index];
        return AnimatedBuilder(
          animation: _letterAnimations[index],
          builder: (context, child) {
            return Opacity(
              opacity: _letterAnimations[index].value,
              child: Text(
                char,
                style: TextStyle(
                  fontSize: widget.size,
                  color: widget.color,
                ),
              ),
            );
          },
        );
      }),
    );
  }
} 