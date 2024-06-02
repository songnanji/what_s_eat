import 'package:flutter/material.dart';
import 'dart:math';

class LadderPage extends StatefulWidget {
  @override
  _LadderPageState createState() => _LadderPageState();
}

class _LadderPageState extends State<LadderPage> {
  final List<String> _choices = ['1', '2', '3', '4', '5', '6'];
  final List<String> _foods = ['피자', '버거', '파스타', '초밥', '샐러드', '스테이크'];
  final List<String> _results = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _generateResults();
  }

  void _generateResults() {
    _results.clear();
    _results.addAll(_foods);
    _results.shuffle(_random);
  }

  void _showResults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('사다리 타기 결과'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_choices.length, (index) {
            return Text('${_choices[index]} -> ${_results[index]}');
          }),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('확인'),
          ),
        ],
      ),
    );
  }

  void _selectChoice(String choice) {
    final index = _choices.indexOf(choice);
    final result = _results[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('선택한 결과'),
        content: Text('$choice -> $result'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
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
        title: Text('사다리 타기'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 400,
              child: CustomPaint(
                painter: LadderPainter(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _generateResults();
                  _showResults();
                });
              },
              child: Text('START'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: _choices.map((choice) {
                return ElevatedButton(
                  onPressed: () {
                    _selectChoice(choice);
                  },
                  child: Text(choice),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class LadderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3.0;

    // Draw vertical lines
    for (int i = 0; i < 5; i++) {
      final x = i * size.width / 4;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    final random = Random();
    for (int i = 0; i < 15; i++) {
      final y = i * size.height / 14;
      final startX = random.nextInt(4) * size.width / 4;
      final endX = startX + size.width / 4;
      canvas.drawLine(Offset(startX, y), Offset(endX, y), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

