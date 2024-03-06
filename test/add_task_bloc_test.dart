
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:task_management/domain/repositories/task_repository_impl.dart';
import 'package:task_management/domain/usecases/add_task_usecase.dart';
import 'package:task_management/presentation/bloc/add_task/add_task_bloc.dart';

import 'add_task_bloc_test.mocks.dart';


@GenerateMocks([TaskRepositoryImpl])

void main() {
  sqfliteFfiInit();
  late MockTaskRepositoryImpl mockTaskRepositoryImpl;
  setUp(() async {
    Database db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await db.execute("CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)");
    mockTaskRepositoryImpl = MockTaskRepositoryImpl()..setDatabase = db;
  });

  group('AddTaskBloc testing', () {
    String taskVal = 'task';
    late AddTaskBloc addTaskBloc;

    setUp(() async {
      addTaskBloc = AddTaskBloc(addTaskUseCase: AddTaskUseCase(mockTaskRepositoryImpl));
    });

    tearDown(() {
      addTaskBloc.close();
    });

    blocTest(
      'emits [AddTaskLoading, AddTaskSuccess] when AddTask event is added',
      build: () => addTaskBloc,
      act: (bloc) => bloc.add(AddTask(task: taskVal)),
      expect: () => [
        isA<AddTaskLoading>(),
        isA<AddTaskSuccess>(),
      ],
    );
  });
}