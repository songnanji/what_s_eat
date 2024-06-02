import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text('My Page'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildUserInfo('이름', '송난지'),
            buildUserInfo('메일', 'nanji@example.com'),
            buildUserInfo('전화번호', '010-1234-5678'),
            SizedBox(height: 20),
            buildMenuButton(context, '좋아하는 음식 리스트', Icons.favorite, '/favoriteList'),
            buildMenuButton(context, '단골 음식점, 맛집', Icons.restaurant, '/favoriteRestaurants'),
            buildMenuButton(context, '싫어하는 음식 리스트', Icons.cancel, '/dislikeList'),
          ],
        ),
      ),
    );
  }

  Widget buildUserInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget buildMenuButton(BuildContext context, String title, IconData icon, String route) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.lightGreen[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50, color: Colors.green),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
