import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:worklify_app/blocs/task/task_bloc.dart';
import 'package:worklify_app/blocs/task/task_state.dart';
import 'package:worklify_app/models/task_model.dart';
import 'package:worklify_app/view/home/home_screen.dart';
import 'package:worklify_app/widgets/task_card.dart';

class CalendarTaskView extends StatefulWidget {
  @override
  State<CalendarTaskView> createState() => _CalendarTaskViewState();
}

class _CalendarTaskViewState extends State<CalendarTaskView> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: _selectedDate,
          firstDay: DateTime(2000),
          lastDay: DateTime(2100),
          selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDate = selectedDay;
            });
          },
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.deepPurple.shade100,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.deepPurple,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskLoadedState) {
                final filteredTasks =
                    state.tasks.where((task) {
                      return task.dueDate.year == _selectedDate.year &&
                          task.dueDate.month == _selectedDate.month &&
                          task.dueDate.day == _selectedDate.day;
                    }).toList();

                if (filteredTasks.isEmpty) {
                  return const Center(child: Text("No tasks for this date."));
                }

                ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    final task = filteredTasks[index];
                    return TaskCard(task: task); // ✅ Reusing same UI
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
