import 'package:flutter/material.dart';
import 'dart:math';

class BallPickPage extends StatefulWidget {
  @override
  _BallPickPageState createState() => _BallPickPageState();
}

class _BallPickPageState extends State<BallPickPage> {
  final List<String> _foodItems = [
    '김치찌개',
    '비빔밥',
    '된장찌개',
    '불고기',
    '비빔국수',
    '삼겹살',
  ];

  String? _selectedFood;

  void _pickRandomFood() {
    final random = Random();
    final selectedFood = _foodItems[random.nextInt(_foodItems.length)];
    setState(() {
      _selectedFood = selectedFood;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('공 추첨'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.casino,
              size: 100,
              color: Colors.green,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickRandomFood,
              child: Text('START'),
            ),
            SizedBox(height: 20),
            if (_selectedFood != null)
              Text(
                '추첨 결과: $_selectedFood',
                style: TextStyle(fontSize: 24),
              ),
          ],
        ),
      ),
    );
  }
}
