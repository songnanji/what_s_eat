import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text('List'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildMenuButton(context, '좋아하는 음식 리스트', Icons.favorite, '/favoriteList'),
            buildMenuButton(context, '단골 음식점, 맛집', Icons.restaurant, '/favoriteRestaurants'),
            buildMenuButton(context, '싫어하는 음식 리스트', Icons.cancel, '/dislikeList'),
          ],
        ),
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
