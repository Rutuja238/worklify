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
        // if (state is HabitInitial) {
        //   context.read<HabitBloc>().add(LoadHabitsEvent());
        //   return const Center(child: CircularProgressIndicator());
        // } 
        if (state is HabitInitial) {
  final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  context.read<HabitBloc>().add(LoadHabitsEvent(userId));
  return const Center(child: CircularProgressIndicator());
}

        else if (state is HabitLoadedState) {
          final habits = state.habits;

          if (habits.isEmpty) {
            return Center(child: Text("No habits yet"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: habits.length,
            itemBuilder: (context, index) {
              final habit = habits[index];
              return _buildHabitCard(habit);
            },
          );
        } else {
          return const Center(child: Text("Something went wrong"));
        }
      },
    );
  }

  Widget _buildHabitCard(HabitModel habit) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(habit.title, style: const TextStyle(fontWeight: FontWeight.bold)),
       subtitle: Text("${habit.subHabits.length} Sub-habit(s)"),

        children: habit.subHabits.map((sub) {
          return ListTile(
            title: Text(sub.title),
            trailing: Text(DateFormat.jm().format(sub.time)),
          );
        }).toList(),
      ),
    );
  }
}
