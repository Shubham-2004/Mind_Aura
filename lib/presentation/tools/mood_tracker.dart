import 'package:flutter/material.dart';
import 'package:mindaura/models/mood_entry.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hive/hive.dart';

class MoodTrackerPage extends StatefulWidget {
  @override
  _MoodTrackerPageState createState() => _MoodTrackerPageState();
}

class _MoodTrackerPageState extends State<MoodTrackerPage> {
  DateTime _selectedDate = DateTime.now();
  double _currentMood = 5.0;
  late Box<MoodEntry> _moodBox;

  @override
  void initState() {
    super.initState();
    _moodBox = Hive.box<MoodEntry>('mood_entries');
  }

  Future<void> _saveMood() async {
    try {
      final existingEntries = _moodBox.values.where(
        (entry) => isSameDay(entry.date, _selectedDate),
      );

      if (existingEntries.isNotEmpty) {
        // Update existing entry
        final existingEntry = existingEntries.first;
        final index = _moodBox.values.toList().indexOf(existingEntry);
        await _moodBox.putAt(
          index,
          MoodEntry(
            date: _selectedDate,
            mood: _currentMood.toInt(),
          ),
        );
      } else {
        // Add new entry
        await _moodBox.add(
          MoodEntry(
            date: _selectedDate,
            mood: _currentMood.toInt(),
          ),
        );
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mood saved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving mood: $e')),
      );
    }

    setState(() {});
  }

  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Map<String, List<MoodEntry>> _groupMoodEntries() {
    final groupedEntries = <String, List<MoodEntry>>{};

    for (var entry in _moodBox.values) {
      final dateString =
          '${entry.date.year}-${entry.date.month.toString().padLeft(2, '0')}-${entry.date.day.toString().padLeft(2, '0')}';
      if (groupedEntries[dateString] == null) {
        groupedEntries[dateString] = [];
      }
      groupedEntries[dateString]!.add(entry);
    }

    return groupedEntries;
  }

  String _getMoodDescription(int mood) {
    if (mood <= 3) {
      return "Sad 😞";
    } else if (mood <= 6) {
      return "Neutral 😐";
    } else if (mood <= 8) {
      return "Happy 🙂";
    } else {
      return "Very Happy 😄";
    }
  }

  @override
  Widget build(BuildContext context) {
    final moodHistory = _groupMoodEntries();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: Text(
          'Mood Tracker',
          style: TextStyle(color: Colors.grey.shade200),
        ),
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
              color: Colors.green.shade100,
              margin: const EdgeInsets.only(bottom: 16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select your mood:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Slider(
                      value: _currentMood,
                      min: 1,
                      max: 10,
                      divisions: 9,
                      label: _currentMood.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          _currentMood = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: _saveMood,
                        child: Text('Save Mood'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Mood History:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            for (var date
                in moodHistory.keys.toList()..sort((a, b) => b.compareTo(a)))
              Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ExpansionTile(
                  title: Text(
                    date,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: moodHistory[date]!
                      .map(
                        (entry) => ListTile(
                          title: Text('Mood: ${entry.mood}'),
                          subtitle: Text(
                              'Description: ${_getMoodDescription(entry.mood)}'),
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
