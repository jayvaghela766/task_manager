import 'package:task_management/data/models/task.dart';

import '../../data/repositories/task_repository.dart';


/// Use case for adding a product.
class AddTaskUseCase {
  final TaskRepository productRepository;

  /// Constructor for the use case.
  AddTaskUseCase(this.productRepository);

  /// Executes the use case by adding the provided product.
  Future<void> execute(Task task) async {
    await productRepository.addTask(task);
  }
}
