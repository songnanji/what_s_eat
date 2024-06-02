import 'package:flutter/material.dart';
import 'dart:math';

class RoulettePage extends StatefulWidget {
  @override
  _RoulettePageState createState() => _RoulettePageState();
}

class _RoulettePageState extends State<RoulettePage> with SingleTickerProviderStateMixin {
  final List<String> _foodItems = ['Pizza', 'Burger', 'Pasta', 'Sushi', 'Salad', 'Steak'];
  final Random _random = Random();
  late AnimationController _animationController;
  late Animation<double> _animation;
  String _selectedFood = '';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 0).animate(_animationController);

    _animationController.addListener(() {
      setState(() {});
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _showSelectedFood();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _spinWheel() {
    final double randomAngle = _random.nextDouble() * 2 * pi;
    final double totalRotation = randomAngle + 2 * pi * 4;
    _animation = Tween<double>(begin: _animation.value, end: _animation.value + totalRotation).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.reset();
    _animationController.forward();
  }

  void _showSelectedFood() {
    final double angle = _animation.value % (2 * pi);
    final int index = (_foodItems.length - (angle / (2 * pi) * _foodItems.length).floor()) % _foodItems.length;
    setState(() {
      _selectedFood = _foodItems[index];
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Result'),
        content: Text('Selected food: $_selectedFood'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text('룰렛 돌리기'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: _animation.value,
                    child: CustomPaint(
                      size: Size(300, 300),
                      painter: _WheelPainter(_foodItems),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: Icon(Icons.arrow_drop_down, size: 50, color: Colors.red),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: _spinWheel,
              child: Text('START'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            SizedBox(height: 20),
            Text(
              'Selected food: $_selectedFood',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  final List<String> items;
  _WheelPainter(this.items);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    final angle = 2 * pi / items.length;
    for (int i = 0; i < items.length; i++) {
      paint.color = i.isEven ? Colors.green : Colors.lightGreen;
      canvas.drawArc(
        Rect.fromLTWH(0, 0, size.width, size.height),
        i * angle,
        angle,
        true,
        paint,
      );
    }

    // Draw text
    for (int i = 0; i < items.length; i++) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: items[i],
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      final x = size.width / 2 + (size.width / 2 - 30) * cos(i * angle + angle / 2) - textPainter.width / 2;
      final y = size.height / 2 + (size.height / 2 - 30) * sin(i * angle + angle / 2) - textPainter.height / 2;
      textPainter.paint(canvas, Offset(x, y));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

