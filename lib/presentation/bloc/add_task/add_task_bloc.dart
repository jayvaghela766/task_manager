
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_management/resource/strings_manager.dart';

import '../../../data/models/task.dart';
import '../../../domain/usecases/add_task_usecase.dart';

part 'add_task_event.dart';
part 'add_task_state.dart';

/// Bloc responsible for handling the logic related to adding a Task.
class AddTaskBloc extends Bloc<AddTaskEvent, AddTaskState> {
  final AddTaskUseCase addTaskUseCase;

  /// Constructor for the AddTaskBloc.
  AddTaskBloc({required this.addTaskUseCase})
      : super(AddTaskInitial()) {
    on<AddTask>(_addTask);
  }


  /// Logic for adding a Task.
  void _addTask(AddTask event, Emitter<AddTaskState> emit) async {
    if (isEmptyField(value: event.task)) {
      emit(AddTaskError(error: StringManager.enterTask));
    }  else {
      emit(AddTaskLoading());
      final task = Task(
        task: event.task,
      );
      await addTaskUseCase.execute(task);
      emit(AddTaskSuccess());
    }
  }
}


bool isEmptyField({required String value}){
  if(value.isEmpty){
    return true;
  }else{
    return false;
  }
}