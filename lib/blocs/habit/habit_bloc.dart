import 'package:flutter_bloc/flutter_bloc.dart';
import 'habit_event.dart';
import 'habit_state.dart';
import '../../models/habit_model.dart';
import 'package:hive/hive.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final Box<HabitModel> habitBox;

  HabitBloc({required this.habitBox}) : super(HabitInitial()) {
    on<LoadHabitsEvent>((event, emit) {
      final habits = habitBox.values
          .where((habit) => habit.userId == event.userId)
          .toList();
      emit(HabitLoadedState(habits));
    });

    on<AddHabitEvent>((event, emit) async {
      await habitBox.add(event.habit);
      final habits = habitBox.values
          .where((habit) => habit.userId == event.habit.userId)
          .toList();
      emit(HabitLoadedState(habits));
    });

    on<DeleteHabitEvent>((event, emit) async {
  await event.habit.delete(); // delete from Hive
  final habits = habitBox.values
      .where((habit) => habit.userId == event.habit.userId)
      .toList();
  emit(HabitLoadedState(habits));
});

on<EditHabitEvent>((event, emit) async {
  final habit = event.updatedHabit;

  // Replace the habit in Hive
  final key = habit.key; // Hive stores keys automatically
  await habitBox.put(key, habit);

  final habits = habitBox.values
      .where((h) => h.userId == habit.userId)
      .toList();
  emit(HabitLoadedState(habits));
});

on<MarkSubHabitCompletedEvent>((event, emit) async {
      final habit = habitBox.get(event.habitKey);
      if (habit != null) {
        final subHabit = habit.subHabits.firstWhere((sub) => sub.title == event.subHabitTitle);
        subHabit.isCompleted = true;

        await habit.save(); // Save the updated status

        final habits = habitBox.values
            .where((habit) => habit.userId == event.userId)
            .toList();
        emit(HabitLoadedState(habits));
      }
    });


  }
}