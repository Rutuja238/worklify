import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:worklify_app/blocs/task/task_bloc.dart';
import 'package:worklify_app/blocs/task/task_event.dart';
import 'package:worklify_app/blocs/task/task_state.dart';
import 'package:worklify_app/models/task_model.dart';
import 'package:worklify_app/routes/app_routes.dart';
import 'package:worklify_app/view/task/task_detail_screen.dart';
import 'package:worklify_app/widgets/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final User? user = FirebaseAuth.instance.currentUser;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    context.read<TaskBloc>().add(LoadTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _screens = [
      _buildTaskListView(),     // Home tasks
      Center(child: Text("Chat Placeholder")),
      SizedBox(),               // Middle Add Button
      _buildCalendarView(),     // Calendar screen
      Center(child: Text("Profile Placeholder")),
    ];

    String displayName = user?.displayName ?? "User";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FF),
      appBar: AppBar(
        title: Text("Hi, $displayName!"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _navIcon(Icons.home_outlined, 0),
            _navIcon(Icons.chat_bubble_outline, 1),
            _buildMiddleButton(),
            _navIcon(Icons.calendar_today_outlined, 3),
            _navIcon(Icons.person_outline, 4),
          ],
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.deepPurple : Colors.grey,
        size: 26,
      ),
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  Widget _buildMiddleButton() {
    return Container(
      height: 58,
      width: 58,
      decoration: const BoxDecoration(
        color: Colors.deepPurple,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.add, color: Colors.white, size: 30),
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addTask);
        },
      ),
    );
  }

  Widget _buildTaskListView() {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is TaskLoadedState) {
          final tasks = state.tasks;
          if (tasks.isEmpty) {
            return const Center(child: Text("No tasks yet"));
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: tasks.length,
            // itemBuilder: (context, index) => _buildTaskCard(tasks[index]),
            itemBuilder: (context, index) => TaskCard(task: tasks[index]),

          );
        } else {
          return const Center(child: Text("Something went wrong"));
        }
      },
    );
  }

  Widget _buildCalendarView() {
    return Column(
      children: [
        TableCalendar(
          focusedDay: _selectedDate,
          firstDay: DateTime(2000),
          lastDay: DateTime(2100),
          selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
          onDaySelected: (selectedDay, _) {
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
          "Tasks on ${_selectedDate.toLocal().toString().split(' ')[0]}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskLoadedState) {
                final tasks = state.tasks.where((task) {
                  return task.dueDate.year == _selectedDate.year &&
                      task.dueDate.month == _selectedDate.month &&
                      task.dueDate.day == _selectedDate.day;
                }).toList();

                if (tasks.isEmpty) {
                  return const Center(child: Text("No tasks for this date"));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: tasks.length,
                  // itemBuilder: (context, index) => _buildTaskCard(tasks[index]),
                  itemBuilder: (context, index) => TaskCard(task: tasks[index]),

                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}
