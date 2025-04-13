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