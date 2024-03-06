import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:task_management/domain/repositories/task_repository_impl.dart';
import 'package:task_management/domain/usecases/delete_tasks_usecase.dart';
import 'package:task_management/domain/usecases/get_tasks_usecase.dart';
import 'package:task_management/presentation/bloc/add_task/add_task_bloc.dart';
import 'package:task_management/presentation/bloc/task_list/task_list_bloc.dart';
import 'package:task_management/presentation/pages/task_list_page.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;


  group(
      "Test create test list page",
  ()
  {
    testWidgets(
      "Verify create test list page",
          (WidgetTester tester) async {
            final taskListBloc = TaskListBloc(
                getTasksUseCase: GetTasksUseCase(TaskRepositoryImpl()),
                deleteTasksUseCase: DeleteTasksUseCase(TaskRepositoryImpl()));

            await tester.pumpWidget(MaterialApp(
              home: BlocProvider<TaskListBloc>(
                create: (BuildContext context) => taskListBloc,
                child: const TaskListPage(),
              ),
            ));


            /// Find Scaffold
            var findScaffold = find.byType(Scaffold);
            expect(findScaffold, findsOneWidget);

            // /// find BlocBuilder
            var findBlocBuilder = find.byType(
                BlocBuilder<TaskListBloc, TaskListState>);
            expect(findBlocBuilder, findsOneWidget);

            // /// find Icon
            var findIcon = find.byType(Icon);
            expect(findIcon, findsOneWidget);

            /// find padding
            var findPadding = find.byKey(const Key('task_list_padding'));
            expect(findPadding, findsOneWidget);

            /// find listview
            var findList = find.byKey(const Key('task_list_listview'));
            expect(findList, findsOneWidget);

            /// find Container
            var findContainer = find.byType(Container);
            expect(findContainer, findsOneWidget);
          }
        );
      },
    );

    group('Check Text field data', () {
      test('check task is empty or not ', () {
        expect(isEmptyField(value: ''), true);
        expect(isEmptyField(value: 'abc'), false);
      });
    });
  }