import 'package:flutter/material.dart';
import 'package:mindaura/models/goal_entry.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hive/hive.dart';

class GoalTrackerPage extends StatefulWidget {
  @override
  _GoalTrackerPageState createState() => _GoalTrackerPageState();
}

class _GoalTrackerPageState extends State<GoalTrackerPage> {
  DateTime _selectedDate = DateTime.now();
  late Box<GoalEntry> _goalBox;

  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _minutesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _goalBox = Hive.box<GoalEntry>('goal_entries');
  }

  Future<void> _addGoal() async {
    final String goal = _goalController.text.trim();
    final int? minutes = int.tryParse(_minutesController.text.trim());

    if (goal.isEmpty || minutes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter valid goal and minutes')),
      );
      return;
    }

    final goalEntry =
        GoalEntry(goal: goal, minutes: minutes, date: _selectedDate);
    await _goalBox.add(goalEntry);

    _goalController.clear();
    _minutesController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Goal added successfully')),
    );

    setState(() {});
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Map<String, List<GoalEntry>> _groupGoalsByDate() {
    final groupedGoals = <String, List<GoalEntry>>{};

    for (var entry in _goalBox.values) {
      final dateString =
          '${entry.date.year}-${entry.date.month.toString().padLeft(2, '0')}-${entry.date.day.toString().padLeft(2, '0')}';
      if (groupedGoals[dateString] == null) {
        groupedGoals[dateString] = [];
      }
      groupedGoals[dateString]!.add(entry);
    }

    return groupedGoals;
  }

  @override
  Widget build(BuildContext context) {
    final goalHistory = _groupGoalsByDate();

    return Scaffold(
      appBar: AppBar(
        title: Text('Goal Tracker'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.yellow.shade100,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TableCalendar(
                  focusedDay: _selectedDate,
                  firstDay: DateTime(2000),
                  lastDay: DateTime(2100),
                  selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDate = selectedDay;
                    });
                  },
                ),
              ),
            ),
            Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Goal for ${_selectedDate.toLocal().toIso8601String().substring(0, 10)}:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 8.0),
                    TextField(
                      controller: _goalController,
                      decoration: InputDecoration(
                        labelText: 'Goal',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _minutesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Minutes',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade200,
                        ),
                        onPressed: _addGoal,
                        child: Text('Add Goal',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Goal History:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            for (var date
                in goalHistory.keys.toList()..sort((a, b) => b.compareTo(a)))
              Card(
                color: Colors.yellow.shade100,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ExpansionTile(
                  title: Text(
                    date,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: goalHistory[date]!
                      .map(
                        (entry) => ListTile(
                          title: Text(entry.goal),
                          subtitle: Text('Minutes: ${entry.minutes}'),
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
