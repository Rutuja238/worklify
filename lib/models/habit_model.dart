import 'package:hive/hive.dart';

part 'habit_model.g.dart'; // This will be generated with build_runner

@HiveType(typeId: 1)
class HabitModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final List<SubHabitModel> subHabits;

  @HiveField(3)
  final String userId;

  HabitModel({
    required this.id,
    required this.title,
    required this.subHabits,
    required this.userId,
  });
}

@HiveType(typeId: 2)
class SubHabitModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final DateTime time;

  SubHabitModel({
    required this.title,
    required this.time,
  });
}