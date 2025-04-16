import 'package:hive/hive.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 1)
class HabitModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  int colorValue;

  @HiveField(3)
  int iconCodePoint;

  @HiveField(4)
  String iconFontFamily;

  @HiveField(5)
  List<SubHabitModel> subHabits;

  @HiveField(6)
  String userId;

  @HiveField(7)
  String repeatOption; 

  HabitModel({
    required this.id,
    required this.title,
    required this.colorValue,
    required this.iconCodePoint,
    required this.iconFontFamily,
    required this.subHabits,
    required this.userId,
    required this.repeatOption,
  });
}

@HiveType(typeId: 2)
class SubHabitModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final DateTime time;

  @HiveField(2)
  late final bool? isCompleted;

  SubHabitModel({
    required this.title,
    required this.time,
    this.isCompleted = false,
  });

  SubHabitModel copyWith({
    String? title,
    DateTime? time,
    bool? isCompleted,
  }) {
    return SubHabitModel(
      title: title ?? this.title,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
