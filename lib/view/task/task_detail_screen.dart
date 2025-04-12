import 'package:flutter/material.dart';
import 'package:worklify_app/models/task_model.dart';
import 'edit_task_screen.dart';

class TaskDetailsScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    Color categoryColor;
    switch (task.category.toLowerCase()) {
      case 'work':
        categoryColor = Colors.blueAccent;
        break;
      case 'exercise':
        categoryColor = Colors.green;
        break;
      case 'personal':
        categoryColor = Colors.orange;
        break;
      default:
        categoryColor = Colors.grey;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditTaskScreen(task: task),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.calendar_today, color: categoryColor),
                const SizedBox(width: 8),
                Text(
                  task.dueDate.toString().split(' ')[0],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Category: ${task.category}',
              style: TextStyle(
                fontSize: 16,
                color: categoryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              task.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
