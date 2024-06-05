import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'Server.dart'; // Server 클래스 임포트 추가

class PlanPage extends StatefulWidget {
  @override
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  DateTime _selectedDay = DateTime.now();
  final TextEditingController _controller = TextEditingController();

  void _addPlan(String plan) {
    if (plan.isNotEmpty) {
      setState(() {
        Server().addDietPlan(_selectedDay, plan);
      });
      _controller.clear();
    }
  }

  void _deletePlan(String plan) {
    setState(() {
      Server().removeDietPlan(_selectedDay, plan);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text('Plan'),
        backgroundColor: Colors.lightGreen[400],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.utc(2030, 1, 1),
            focusedDay: _selectedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.lightGreen[400],
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ),
            startingDayOfWeek: StartingDayOfWeek.monday,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: '식단을 입력하세요...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _addPlan(_controller.text);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: Server().getDietPlans(_selectedDay).length,
              itemBuilder: (context, index) {
                final plan = Server().getDietPlans(_selectedDay)[index];
                return ListTile(
                  title: Text(plan),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deletePlan(plan);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
