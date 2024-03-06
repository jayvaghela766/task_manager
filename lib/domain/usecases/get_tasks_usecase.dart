import '../../data/models/task.dart';
import '../../data/repositories/task_repository.dart';

/// Use case for getting tasks.
class GetTasksUseCase {
  final TaskRepository taskRepository;

  /// Constructor for the use case.
  GetTasksUseCase(this.taskRepository);

  /// Executes the use case by retrieving all tasks.
  Future<List<Task>> execute() async {
    return await taskRepository.getAllTasks();
  }
}
