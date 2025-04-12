import 'package:flutter/material.dart';
import 'package:worklify_app/models/task_model.dart';
import 'edit_task_screen.dart';

class TaskDetailsScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailsScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Task Details'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        iconTheme: Theme.of(context).iconTheme,
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
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Category: ${task.category}',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: categoryColor,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              task.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
