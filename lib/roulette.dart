import 'package:flutter/material.dart';
import 'dart:math';
import 'Server.dart';

class RoulettePage extends StatefulWidget {
  @override
  _RoulettePageState createState() => _RoulettePageState();
}

class _RoulettePageState extends State<RoulettePage> with SingleTickerProviderStateMixin {
  List<String> _foodItems = [];
  final Random _random = Random();
  late AnimationController _animationController;
  late Animation<double> _animation;
  String _selectedFood = '';

  @override
  void initState() {
    super.initState();
    _initializeFoodItems();
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

  void _initializeFoodItems() {
    final allFavorites = Server().getFavoriteFoods();
    if (allFavorites.length >= 6) {
      _foodItems = List.from(allFavorites)..shuffle(_random);
      _foodItems = _foodItems.sublist(0, 6);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _spinWheel() {
    if (_foodItems.length < 6) {
      _showErrorDialog();
      return;
    }

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
        content: Text('오늘 메뉴는  $_selectedFood'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('등록된 리스트의 항목이 없거나 부족합니다. 항목을 추가하겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('취소'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/favoriteList');
            },
            child: Text('확인'),
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
        title: Text('Roulette'),
        backgroundColor: Colors.lightGreen[400],
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              Navigator.pushNamed(context, '/favoriteList');
            },
          ),
        ],
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
                    child: Icon(Icons.arrow_drop_down, size: 50, color: Colors.red[300]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: _spinWheel,
              child: Text('START'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[900]),
            ),
            SizedBox(height: 20),
            Text(
              '오늘 메뉴는 $_selectedFood',
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
      paint.color = i.isEven ? Colors.lightGreen : Colors.green;
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
