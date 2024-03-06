
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/data/models/task.dart';
import 'package:task_management/presentation/bloc/task_list/task_list_bloc.dart';

import '../../domain/repositories/task_repository_impl.dart';
import '../../domain/usecases/delete_tasks_usecase.dart';
import '../../domain/usecases/get_tasks_usecase.dart';
import '../../resource/strings_manager.dart';
import 'add_task_page.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      /// Provide TaskListBloc to the widget tree
      create: (BuildContext context) =>
      TaskListBloc(
        getTasksUseCase: GetTasksUseCase(TaskRepositoryImpl()),
        deleteTasksUseCase: DeleteTasksUseCase(TaskRepositoryImpl()),
      )
        ..add(FetchTasksEvent()),

      /// Fetch tasks on page load
      child: BlocBuilder<TaskListBloc, TaskListState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text(StringManager.taskList)),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTaskPage(),
                    ))
                    .then((value) =>
                    context.read<TaskListBloc>().add(FetchTasksEvent()));
              },
              child: const Icon(Icons.add),

              /// Add task button
            ),
            body: Padding(
              key: const Key('task_list_padding'),
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: ListView.separated(
                key: const Key('task_list_listview'),
                itemCount: context
                    .watch<TaskListBloc>()
                    .tasks
                    .length,
                itemBuilder: (context, index) {
                  final task = context
                      .watch<TaskListBloc>()
                      .tasks[index];
                  return Container(
                    /// Container for each task item
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1.0),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 5,
                              color: Colors.black38,
                              offset: Offset(1, 3))
                        ]),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      key: const Key('task_list_row'),
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Row(
                              // key: const Key('task_list_title_row'),
                              children: [
                                Text(task.task),
                              ],
                            ),
                            trailing: GestureDetector(
                                onTap: () {
                                  showAlertDialog(
                                      context, context.read<TaskListBloc>(), task);
                                },
                                child: const Icon(Icons.delete_outline)),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  /// Show logout confirmation dialog
  void showAlertDialog(BuildContext context, TaskListBloc taskListBloc, Task task) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alert'),
            content: const Text(StringManager.areYouSureWantToDelete),
            actions: <Widget>[
              TextButton(
                child: const Text(StringManager.no),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Text(StringManager.yes),
                onPressed: () {
                  Navigator.pop(context);
                  taskListBloc.add(DeleteTaskEvent(id: task.id!));
                },
              ),
            ],
          );
        });
  }
}
