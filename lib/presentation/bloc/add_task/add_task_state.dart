part of 'add_task_bloc.dart';

@immutable
abstract class AddTaskState {}

class AddTaskInitial extends AddTaskState {}

class AddTaskLoading extends AddTaskState {}

class AddTaskSuccess extends AddTaskState {}

class AddTaskError extends AddTaskState {
  final String error;
  AddTaskError({required this.error});
}

