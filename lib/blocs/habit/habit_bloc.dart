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
  }
} 
