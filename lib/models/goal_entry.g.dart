// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalEntryAdapter extends TypeAdapter<GoalEntry> {
  @override
  final int typeId = 2;

  @override
  GoalEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalEntry(
      goal: fields[0] as String,
      minutes: fields[1] as int,
      date: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, GoalEntry obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.goal)
      ..writeByte(1)
      ..write(obj.minutes)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
