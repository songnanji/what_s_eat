import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class PlanPage extends StatefulWidget {
  @override
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  Map<DateTime, List<String>> _dietPlans = {};
  final TextEditingController _controller = TextEditingController();
  DateTime _selectedDay = DateTime.now();

  void _addPlan(String plan) {
    if (plan.isNotEmpty) {
      setState(() {
        if (_dietPlans[_selectedDay] == null) {
          _dietPlans[_selectedDay] = [];
        }
        _dietPlans[_selectedDay]!.add(plan);
      });
      _controller.clear();
    }
  }

  void _deletePlan(String plan) {
    setState(() {
      _dietPlans[_selectedDay]!.remove(plan);
      if (_dietPlans[_selectedDay]!.isEmpty) {
        _dietPlans.remove(_selectedDay);
      }
    });
  }

  List<String> _getPlansForDay(DateTime day) {
    return _dietPlans[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      appBar: AppBar(
        title: Text('식단 계획'),
        backgroundColor: Colors.green,
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
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.greenAccent,
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
              itemCount: _getPlansForDay(_selectedDay).length,
              itemBuilder: (context, index) {
                final plan = _getPlansForDay(_selectedDay)[index];
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

