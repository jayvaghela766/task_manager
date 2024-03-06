import '../../data/repositories/task_repository.dart';

/// Use case for getting tasks.
class DeleteTasksUseCase {
  final TaskRepository taskRepository;

  /// Constructor for the use case.
  DeleteTasksUseCase(this.taskRepository);

  /// Executes the use case by retrieving all tasks.
  Future<int> execute(int taskId) async {
    return await taskRepository.deleteTask(taskId);
  }
}
