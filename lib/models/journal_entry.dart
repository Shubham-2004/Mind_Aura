import 'package:hive/hive.dart';

part 'journal_entry.g.dart';

@HiveType(typeId: 0)
class JournalEntry extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final String gratitude;

  @HiveField(2)
  final String purpose;

  @HiveField(3)
  final String positivity;

  @HiveField(4)
  final String strengths;

  JournalEntry({
    required this.date,
    required this.gratitude,
    required this.purpose,
    required this.positivity,
    required this.strengths,
  });
}
