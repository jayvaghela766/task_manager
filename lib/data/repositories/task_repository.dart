import '../models/task.dart';

/// An abstract class defining the interface for interacting with tasks in a repository.
abstract class TaskRepository {
  /// Asynchronously adds a task to the repository.
  Future<void> addTask(Task task);

  /// Asynchronously retrieves all tasks from the repository.
  Future<List<Task>> getAllTasks();

  Future<int> deleteTask(int taskId);
}
