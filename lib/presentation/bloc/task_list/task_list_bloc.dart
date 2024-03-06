
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/models/task.dart';
import '../../../domain/usecases/delete_tasks_usecase.dart';
import '../../../domain/usecases/get_tasks_usecase.dart';

part 'task_list_event.dart';

part 'task_list_state.dart';

/// Bloc responsible for managing the product list state and events.
class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  final GetTasksUseCase getTasksUseCase;
  final DeleteTasksUseCase deleteTasksUseCase;
  List<Task> tasks = <Task>[];

  /// Constructor for the ProductListBloc.
  TaskListBloc({
    required this.getTasksUseCase,
    required this.deleteTasksUseCase,
  }) : super(TaskListInitial()) {
    on<FetchTasksEvent>(_fetchProductsEvent);
    on<DeleteTaskEvent>(_deleteTaskEvent);
  }

  // /// Logic for handling the logout user event.
  // void _deleteTaskEvent(
  //     LogOutUserEvent event, Emitter<ProductListState> emit) async {
  //   await logoutUseCase.execute();
  //   emit(LogOutSuccess());
  // }

  _fetchProductsEvent(
      FetchTasksEvent event, Emitter<TaskListState> emit) async {
    tasks = await getTasksUseCase.execute();
    emit(TaskListLoaded());
  }

  _deleteTaskEvent(DeleteTaskEvent event, Emitter<TaskListState> emit) async {
    int id = await deleteTasksUseCase.execute(event.id);
    if (id > 0) {
      // Item successfully deleted
      tasks.removeWhere((element) => element.id == event.id);
    }
    emit(TaskListLoaded());
  }
}
