import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  DateTime dueDate;

  @HiveField(3)
  String category;

   @HiveField(4)
  String userId;

  TaskModel({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    required this.userId,
  });
}
