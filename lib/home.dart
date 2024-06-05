import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text('오늘 뭐 먹지'),
        backgroundColor: Colors.lightGreen[400],
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            HomePageButton(
              label: 'Alarm',
              icon: Icons.notifications,
              route: '/alarm',
            ),
            HomePageButton(
              label: 'My page',
              icon: Icons.person,
              route: '/mypage',
            ),
            HomePageButton(
              label: 'Random',
              icon: Icons.casino,
              route: '/random',
            ),
            HomePageButton(
              label: 'Chat',
              icon: Icons.chat,
              route: '/chat',
            ),
            HomePageButton(
              label: 'Plan',
              icon: Icons.calendar_today,
              route: '/plan',
            ),
            HomePageButton(
              label: 'List',
              icon: Icons.list,
              route: '/list',
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String route;

  HomePageButton({
    required this.label,
    required this.icon,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        color: Colors.lightGreen[200],
        margin: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                size: 70.0,
                color: Colors.green[500],
              ),
              SizedBox(height: 10),
              Text(
                label,
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
