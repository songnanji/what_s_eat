import 'package:flutter/material.dart';

class AlarmPage extends StatefulWidget {
  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  bool isDietPlanAlarmOn = false;
  bool isMealRecommendationAlarmOn = false;

  void _toggleDietPlanAlarm() {
    setState(() {
      isDietPlanAlarmOn = !isDietPlanAlarmOn;
    });
    if (isDietPlanAlarmOn) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('등록한 식단표를 당일 오전 8시에 알람이 갑니다'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('확인'),
            ),
          ],
        ),
      );
    }
  }

  void _toggleMealRecommendationAlarm() {
    setState(() {
      isMealRecommendationAlarmOn = !isMealRecommendationAlarmOn;
    });
    if (isMealRecommendationAlarmOn) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('오전 7시, 11시, 오후 17시에 총 3번 메뉴를 추천해드립니다'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('확인'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text('Alarm'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildAlarmRow(
              '식단표 알림',
              isDietPlanAlarmOn,
              _toggleDietPlanAlarm,
            ),
            SizedBox(height: 20),
            _buildAlarmRow(
              '식사 메뉴 추천',
              isMealRecommendationAlarmOn,
              _toggleMealRecommendationAlarm,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlarmRow(
      String title,
      bool isOn,
      VoidCallback toggleAlarm,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: isOn ? Colors.green : Colors.grey,
          ),
          onPressed: toggleAlarm,
        ),
        IconButton(
          icon: Icon(
            Icons.notifications_off,
            color: !isOn ? Colors.green : Colors.grey,
          ),
          onPressed: toggleAlarm,
        ),
      ],
    );
  }
}
