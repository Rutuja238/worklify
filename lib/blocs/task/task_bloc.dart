import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:worklify_app/models/task_model.dart';

import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final Box<TaskModel> taskBox;

  TaskBloc(this.taskBox) : super(TaskInitialState()) {
    on<LoadTasksEvent>((event, emit) async {
      emit(TaskLoadingState());

      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      if (currentUserId == null) {
        emit(TaskErrorState("User not logged in"));
        return;
      }

      final userTasks = taskBox.values
      .where((task) => task.userId == currentUserId)
      .toList();

      emit(TaskLoadedState(userTasks));
    });

    on<AddTaskEvent>((event, emit) async {
      emit(TaskLoadingState());

      await taskBox.add(event.task);

      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      final tasks = taskBox.values
          .where((task) => task.userId == currentUserId)
          .toList();

      emit(TaskLoadedState(tasks));
    });

    on<DeleteTaskEvent>((event, emit) async {
      emit(TaskLoadingState());

      await event.task.delete();

      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      final tasks = taskBox.values
          .where((task) => task.userId == currentUserId)
          .toList();

      emit(TaskLoadedState(tasks));
    });

    on<UpdateTaskEvent>((event, emit) async {
      emit(TaskLoadingState());

      await event.task.save();

      final currentUserId = FirebaseAuth.instance.currentUser?.uid;
      final tasks = taskBox.values
          .where((task) => task.userId == currentUserId)
          .toList();

      emit(TaskLoadedState(tasks));
    });
  }
}
