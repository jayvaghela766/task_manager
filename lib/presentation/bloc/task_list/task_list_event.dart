part of 'task_list_bloc.dart';

@immutable
abstract class TaskListEvent {}

class FetchTasksEvent extends TaskListEvent {}

class DeleteTaskEvent extends TaskListEvent {
  final int id;
  DeleteTaskEvent({required this.id});
}
