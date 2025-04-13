import 'package:equatable/equatable.dart';
import '../../models/habit_model.dart';

abstract class HabitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HabitInitial extends HabitState {}

class HabitLoadedState extends HabitState {
  final List<HabitModel> habits;

  HabitLoadedState(this.habits);

  @override
  List<Object?> get props => [habits];
} 