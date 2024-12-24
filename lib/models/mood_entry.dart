import 'package:hive/hive.dart';

part 'mood_entry.g.dart';

@HiveType(typeId: 1)
class MoodEntry {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final int mood; // Mood value (e.g., 1 to 10)

  MoodEntry({required this.date, required this.mood});
}
