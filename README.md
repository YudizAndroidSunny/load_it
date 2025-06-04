# Load It
![](https://raw.githubusercontent.com/YudizAndroidSunny/load_it/main/assets/images/banner.png)

[![pub package](https://img.shields.io/pub/v/load_it.svg)](https://pub.dev/packages/load_it)
[![package publisher](https://img.shields.io/pub/publisher/load_it.svg)](https://pub.dev/packages/load_it/publisher)
![GitHub code size](https://img.shields.io/github/languages/code-size/YudizAndroidSunny/load_it)

A beautiful and customizable collection of loading indicators for Flutter applications. This package provides a wide variety of animated loading indicators that can be easily integrated into your Flutter projects.

## Features

- 25+ Beautiful loading indicators
- Customizable colors and sizes
- Smooth animations
- Easy to use
- Lightweight
- Well-documented
- MIT Licensed

## Demo
<img src="https://raw.githubusercontent.com/YudizAndroidSunny/load_it/main/assets/images/demo.gif"/>


## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  load_it: ^0.0.2
```

Then run:

```bash
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:load_it/load_it.dart';
```

### Basic Usage

All indicators follow a similar pattern and can be customized with `color` and `size` parameters:

```dart
// Example with default values
BouncingDotsIndicator()

// Example with custom values
BouncingDotsIndicator(
  color: Colors.blue,
  size: 50.0,
)
```

## Available Indicators

### 1. BouncingDotsIndicator
A loading indicator that shows three dots bouncing up and down in sequence, creating a wave-like animation effect.

### 2. ChasingDotsIndicator
Dots that chase each other in a circular pattern, creating a playful loading animation.

### 3. ClockLoaderIndicator
A clock-like indicator with rotating hour and minute hands, perfect for time-related operations.

### 4. CubeSpinnerIndicator
A 3D rotating cube that provides a modern and engaging loading experience.

### 5. DualRingIndicator
Two concentric rings rotating in opposite directions, creating an elegant loading effect.

### 6. FlipDotsIndicator
Dots that flip with a 3D effect, creating an engaging loading animation.

### 7. FlowBarLoader
A smooth flowing bar animation that creates a liquid-like loading effect.

### 8. GridPulseLoader
A grid of dots that pulse in a wave-like pattern, creating a modern loading effect.

### 9. HelixSpinLoader
A helix-shaped loading indicator that spins around its axis.

### 10. HexagonPulseIndicator
A hexagonal shape that pulses with a smooth animation.

### 11. LinearDotsPauseIndicator
Dots that move in a linear pattern with a pause effect.

### 12. OrbitLoaderIndicator
A dot that orbits around a center point while rotating around its own axis.

### 13. PulsingCircleIndicator
A circle that expands and contracts while fading in and out.

### 14. PulseOrbitLoader
A combination of pulsing and orbiting effects for a dynamic loading animation.

### 15. RotatingLineFadeIndicator
A line that rotates continuously while fading in and out.

### 16. RotatingSquareIndicator
A square that rotates smoothly around its center.

### 17. RotatingTriangleIndicator
A triangle that rotates continuously with a smooth animation.

### 18. ScalingBlocksIndicator
Three blocks that scale up and down in sequence, creating a wave-like effect.

### 19. SpinningArcIndicator
An arc that spins around its center, creating a simple yet effective loading animation.

### 20. SplitRingBounceIndicator
A ring that splits into two parts, bouncing and rotating simultaneously.

### 21. StretchingBarIndicator
A single bar that stretches up and down with a smooth animation.

### 22. TextPulseLoader
A text-based loader where each letter pulses in sequence.

### 23. TriangleCircularLoader
A triangle that moves in a circular pattern while rotating.

### 24. TwistTriangleLoader
A triangle that twists and rotates, creating a dynamic loading effect.

### 25. TypingDotsIndicator
Three dots that fade in and out, simulating a typing animation.

### 26. VortexSpinnerIndicator
Dots that spin in a vortex pattern, creating an engaging loading effect.

### 27. WaterBubblesIndicator
Bubbles that rise and pop, creating a water-like loading animation.

### 28. ZigzagLoaderIndicator
Dots that move in a zigzag pattern, creating a wave-like motion.

## Customization

All indicators support the following customization options:

- `color`: The color of the indicator (default: Material Blue)
- `size`: The size of the indicator (default: 40.0)

## Example

```dart
import 'package:flutter/material.dart';
import 'package:load_it/load_it.dart';

class MyLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BouncingDotsIndicator(
            color: Colors.blue,
            size: 50.0,
          ),
          SizedBox(height: 20),
          Text('Loading...'),
        ],
      ),
    );
  }
}
```

## Contributors ✨

Thanks goes to these wonderful people 💻:
<table>
  <tbody>
    <tr>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/YudizAndroidSunny"><img src="https://avatars.githubusercontent.com/u/137782850?v=4?s=100" width="100px;" alt="YudizAndroidSunny"/><br /><sub><b>YudizAndroidSunny</b></sub></a><br />💻</td>
      <td align="center" valign="top" width="14.28%"><a href="https://github.com/YudizAndroidVarshil"><img src="https://avatars.githubusercontent.com/u/165645464?v=4?s=100" width="100px;" alt="YudizAndroidVarshil"/><br /><sub><b>YudizAndroidVarshil</b></sub></a><br />💻</td>
    </tr>
  </tbody>
</table>

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

If you find any issues or have suggestions, please [open an issue](https://github.com/YudizAndroidSunny/load_it/issues) on GitHub.

## Visitors Count 
<img align="left" src = "https://profile-counter.glitch.me/load_it/count.svg" alt ="Loading">
