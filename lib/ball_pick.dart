import 'package:flutter/material.dart';
import 'dart:math';
import 'Server.dart';

class BallPickPage extends StatefulWidget {
  @override
  _BallPickPageState createState() => _BallPickPageState();
}

class _BallPickPageState extends State<BallPickPage> {
  String? _selectedFood;

  void _pickRandomFood() {
    List<String> availableFoods = Server().getAvailableFoods();
    if (availableFoods.isEmpty) {
      _showNoItemsDialog();
      return;
    }

    final random = Random();
    final selectedFood = availableFoods[random.nextInt(availableFoods.length)];
    setState(() {
      _selectedFood = selectedFood;
    });
  }

  void _showNoItemsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('등록된 리스트의 항목이 없습니다. 항목을 추가하겠습니까?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushNamed(context, '/dislikeList');
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
      appBar: AppBar(
        title: Text('Ball pick'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.casino,
              size: 200,
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
                '오늘 메뉴는 $_selectedFood',
                style: TextStyle(fontSize: 24),
              ),
          ],
        ),
      ),
    );
  }
}
