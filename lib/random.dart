import 'package:flutter/material.dart';

class RandomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text('Random'),
        backgroundColor: Colors.lightGreen[400],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildMenuButton(context, '룰렛 돌리기', '좋아하는 음식 리스트에 등록한 항목들로 구성', '/roulette', Icons.sports_basketball_rounded),
            buildMenuButton(context, '사다리 타기', '단골 음식점, 맛집 리스트에 등록한 항목들로 구성', '/ladder', Icons.pan_tool_alt_rounded),
            buildMenuButton(context, '공 추첨', '여러가지 메뉴 항목들 중 하나를 무작위로 추천', '/ballPick', Icons.fiber_smart_record_outlined),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(BuildContext context, String title, String subtitle, String route, IconData icon) {
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
            color: Colors.lightGreen[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, size: 50, color: Colors.lightGreen[400],)
              ,SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green[900]),
                    ),
                    SizedBox(height: 10),
                    Text(subtitle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
