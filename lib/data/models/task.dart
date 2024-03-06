/// Class representing a Task in an e-commerce system
class Task {
  /// Attributes of the Task
  final String task;
  final int? id;

  /// Constructor for creating a new Task instance
  Task({
    this.id,
    required this.task,
  });

  /// Method to convert the Task object into a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': task,
    };
  }

  /// Factory constructor to create a Task object from a map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      task: map['task'],
    );
  }
}
