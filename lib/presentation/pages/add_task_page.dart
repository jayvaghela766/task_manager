import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/domain/usecases/add_task_usecase.dart';
import 'package:task_management/resource/strings_manager.dart';
import '../../domain/repositories/task_repository_impl.dart';
import '../bloc/add_task/add_task_bloc.dart';
import '../common_component/common_editext_view.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});

  String task = '';
  void setName(String value) => task = value;

  String errorTask = '';
  void setErrorTask(String value) => errorTask = value;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddTaskBloc(
          addTaskUseCase: AddTaskUseCase(TaskRepositoryImpl())),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(StringManager.addTask),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AddTaskBloc, AddTaskState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _task(context), // task name text field widget
                           // Category text field widget
                          const SizedBox(height: 25),

                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<AddTaskBloc>().add(AddTask(task: task)),
                    child: state is AddTaskLoading
                        ? const CircularProgressIndicator()
                        : const Text(StringManager.addTask),
                  ),
                ],
              );
            },
            listener: (BuildContext context, AddTaskState state) {
              if (state is AddTaskSuccess) {
                // Show snackbar on success
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(StringManager.taskAddedSuccessfully),
                  ),
                );
                // Navigate back
                Navigator.pop(context);
              }

              if(state is AddTaskError){
                setErrorTask(state.error);
              }

            },
          ),
        ),
      ),
    );
  }

  // Widget for task name text field
  Widget _task(BuildContext context) {
    return TextInputField(
      isPasswordField: false,
      errorText: errorTask,
      hintText: StringManager.task,
      textInputType: TextInputType.text,
      onChanged: (val) {
        if (val!.isNotEmpty) {
          setName(val);
        }
      },
    );
  }
}
