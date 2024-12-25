import 'package:flutter/material.dart';
import 'package:mindaura/models/journal_entry.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:hive/hive.dart';

class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  DateTime _selectedDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  final _gratitudeController = TextEditingController();
  final _purposeController = TextEditingController();
  final _positivityController = TextEditingController();
  final _strengthsController = TextEditingController();
  late Box<JournalEntry> _journalBox;

  @override
  void initState() {
    super.initState();
    _journalBox = Hive.box<JournalEntry>('journal_entries');
  }

  @override
  void dispose() {
    _gratitudeController.dispose();
    _purposeController.dispose();
    _positivityController.dispose();
    _strengthsController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final newEntry = JournalEntry(
        date: _selectedDate,
        gratitude: _gratitudeController.text,
        purpose: _purposeController.text,
        positivity: _positivityController.text,
        strengths: _strengthsController.text,
      );

      await _journalBox.add(newEntry);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Journal entry saved!')),
      );

      _gratitudeController.clear();
      _purposeController.clear();
      _positivityController.clear();
      _strengthsController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        title: Text(
          'Your Journal',
          style: TextStyle(color: Colors.grey.shade200),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _gratitudeController,
                        decoration: InputDecoration(
                            labelText: 'Gratitude',
                            hintText: 'Things I am Grateful for Today',
                            hintStyle: TextStyle(color: Colors.grey)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter gratitude.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _purposeController,
                        decoration: InputDecoration(
                            labelText: 'Purpose',
                            hintText: 'Ex. Helped Someone Today',
                            hintStyle: TextStyle(color: Colors.grey)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your purpose.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _positivityController,
                        decoration: InputDecoration(
                            labelText: 'Positivity',
                            hintText: 'What I liked about myself today',
                            hintStyle: TextStyle(color: Colors.grey)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter positivity.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _strengthsController,
                        decoration: InputDecoration(
                            labelText: 'Strengths',
                            hintText: 'My Strengths',
                            hintStyle: TextStyle(color: Colors.grey)),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your strengths.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green.shade200,
                        ),
                        onPressed: _submitForm,
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Your Journals :-',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8.0),
            ..._journalBox.values.map((entry) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                color: Colors.yellow.shade100,
                child: ListTile(
                  title: Text(
                    '${entry.date.toLocal()}'.split(' ')[0],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Gratitude: ${entry.gratitude}'),
                      Text('Purpose: ${entry.purpose}'),
                      Text('Positivity: ${entry.positivity}'),
                      Text('Strengths: ${entry.strengths}'),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
