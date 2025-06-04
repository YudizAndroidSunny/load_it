import 'package:flutter/material.dart';
import 'package:load_it/load_it.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Load It Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color _selectedColor = Colors.blue;
  double _selectedSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Load It Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          _buildCustomizationPanel(),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(16),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _buildIndicatorCard(
                  'Bouncing Dots',
                  BouncingDotsIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Chasing Dots',
                  ChasingDotsIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Clock Loader',
                  ClockLoaderIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Cube Spinner',
                  CubeSpinnerIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Dual Ring',
                  DualRingIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Flip Dots',
                  FlipDotsIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Flow Bar',
                  FlowBarLoader(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Grid Pulse',
                  GridPulseLoader(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Helix Spin',
                  HelixSpinLoader(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Hexagon Pulse',
                  HexagonPulseIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Linear Dots With Pause',
                  LinearDotsWithPause(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Orbit Loader',
                  OrbitLoaderIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Pulse Orbit Loader',
                  PulseOrbitLoader(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Pulsing Circle',
                  PulsingCircleIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Rotating Line Fade',
                  RotatingLineFadeIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Rotating Square',
                  RotatingSquareIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Rotating Triangle',
                  RotatingTriangleIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Scaling Blocks',
                  ScalingBlocksIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Spinning Arc',
                  SpinningArcIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Split Ring Bounce',
                  SplitRingBounceIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Stretching Bar',
                  StretchingBarIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Text Pulse',
                  TextPulseLoader(
                    color: _selectedColor,
                    size: _selectedSize/2,
                  ),
                ),
                _buildIndicatorCard(
                  'Triangle Circular',
                  TriangleCircularLoader(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Twist Triangle',
                  TwistTriangleLoader(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Typing Dots',
                  TypingDotsIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Vortex Spinner',
                  VortexSpinnerIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Water Bubbles',
                  WaterBubblesIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
                _buildIndicatorCard(
                  'Zigzag Loader',
                  ZigzagLoaderIndicator(
                    color: _selectedColor,
                    size: _selectedSize,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomizationPanel() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text('Color: '),
              const SizedBox(width: 8),
              _buildColorPicker(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('Size: '),
              const SizedBox(width: 8),
              Expanded(
                child: Slider(
                  value: _selectedSize,
                  min: 30,
                  max: 100,
                  divisions: 7,
                  label: _selectedSize.round().toString(),
                  onChanged: (value) => setState(() => _selectedSize = value),
                ),
              ),
              Text('${_selectedSize.round()}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorPicker() {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.teal,
    ];

    return Row(
      children: colors.map((color) {
        return GestureDetector(
          onTap: () => setState(() => _selectedColor = color),
          child: Container(
            width: 32,
            height: 32,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: _selectedColor == color
                    ? Colors.white
                    : Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildIndicatorCard(String title, Widget indicator) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(child: Center(child: indicator)),
          ],
        ),
      ),
    );
  }
}