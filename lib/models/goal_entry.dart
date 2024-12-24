import 'package:hive/hive.dart';

part 'goal_entry.g.dart';

@HiveType(typeId: 2)
class GoalEntry {
  @HiveField(0)
  final String goal;

  @HiveField(1)
  final int minutes;

  @HiveField(2)
  final DateTime date;

  GoalEntry({required this.goal, required this.minutes, required this.date});
}
