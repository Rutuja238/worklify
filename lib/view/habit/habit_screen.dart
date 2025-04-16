import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../../blocs/habit/habit_bloc.dart';
import '../../blocs/habit/habit_event.dart';
import '../../blocs/habit/habit_state.dart';
import '../../models/habit_model.dart';

class HabitScreen extends StatelessWidget {
  const HabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HabitBloc, HabitState>(
      builder: (context, state) {
        if (state is HabitInitial) {
          final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
          context.read<HabitBloc>().add(LoadHabitsEvent(userId));
          return const Center(child: CircularProgressIndicator());
        } else if (state is HabitLoadedState) {
          final habits = state.habits;
          if (habits.isEmpty) {
            return const Center(child: Text("No habits yet"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              return _buildHabitCard(context, habit);
            },
          );
        } else {
          return const Center(child: Text("Something went wrong"));
        }
      },
    );
  }

  Widget _buildHabitCard(BuildContext context, HabitModel habit) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(habit.colorValue),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        collapsedIconColor: Colors.white,
        iconColor: Colors.white,
        title: Row(
          children: [
            Icon(
              IconData(habit.iconCodePoint, fontFamily: habit.iconFontFamily),
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Text(
              habit.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const Spacer(),
            Text(
              habit.repeatOption ?? '',
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
        children: habit.subHabits.map((sub) {
          return ListTile(
            title: Text(sub.title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(DateFormat.jm().format(sub.time)),
                Checkbox(
                  value: sub.isCompleted ?? false,
                  onChanged: (value) {
                    context.read<HabitBloc>().add(MarkSubHabitCompletedEvent(
                      habitKey: habit.key.toString(),
                      subHabitTitle: sub.title,
                      userId: habit.userId,
                      isCompleted: value ?? false,
                    ));
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
