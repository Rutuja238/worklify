import 'package:worklify_app/models/task_model.dart';

abstract class TaskState {}

class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<TaskModel> tasks;

  TaskLoadedState(this.tasks);
}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState(this.message);
}

class TaskAddedState extends TaskState {} 
