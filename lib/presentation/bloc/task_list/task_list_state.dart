part of 'task_list_bloc.dart';

/// Abstract class representing states related to the task list.
@immutable
abstract class TaskListState {}

/// Initial state when the task list starts.
class TaskListInitial extends TaskListState {}

/// State indicating that the task list is being loaded.
class TaskListLoading extends TaskListState {}

/// State indicating that the task list has been successfully loaded.
class TaskListLoaded extends TaskListState {}

/// State indicating that an error occurred while loading the task list.
class TaskListError extends TaskListState {}

/// State indicating that the user has been successfully logged out.
class DeleteTaskSuccess extends TaskListState {}
