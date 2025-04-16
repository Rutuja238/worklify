import '../../models/habit_model.dart';
import 'package:equatable/equatable.dart';

abstract class HabitEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadHabitsEvent extends HabitEvent {
  final String userId;

  LoadHabitsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class AddHabitEvent extends HabitEvent {
  final HabitModel habit;

  AddHabitEvent(this.habit);

  @override
  List<Object?> get props => [habit];
}

class DeleteHabitEvent extends HabitEvent {
  final HabitModel habit;
  DeleteHabitEvent(this.habit);
}

class EditHabitEvent extends HabitEvent {
  final HabitModel updatedHabit;

  EditHabitEvent(this.updatedHabit);

  @override
  List<Object?> get props => [updatedHabit];
}

class MarkSubHabitCompletedEvent extends HabitEvent {
  final String habitKey;
  final String subHabitTitle;
  final String userId;
  

  MarkSubHabitCompletedEvent({
    required this.habitKey,
    required this.subHabitTitle,
    required this.userId, required bool isCompleted,
  });

  @override
  List<Object?> get props => [habitKey, subHabitTitle, userId];
}
