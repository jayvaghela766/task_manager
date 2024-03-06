part of 'add_task_bloc.dart';

@immutable
abstract class AddTaskEvent {}

class AddTask extends AddTaskEvent {
  final String task;
  AddTask({required this.task});
}
