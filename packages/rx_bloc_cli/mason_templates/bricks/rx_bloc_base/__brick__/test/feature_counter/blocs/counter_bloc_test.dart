// Copyright (c) 2021, Prime Holding JSC
// https://www.primeholding.com
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:{{project_name}}/feature_counter/blocs/counter_bloc.dart';
import 'package:{{project_name}}/base/repositories/counter_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rx_bloc_test/rx_bloc_test.dart';

import 'counter_bloc_test.mocks.dart';

@GenerateMocks([CounterRepository])
void main() {
  late MockCounterRepository repo;

  setUp(() {
    repo = MockCounterRepository();
  });

  group('CounterBloc tests', () {
    rxBlocTest<CounterBlocType, int>(
      'Initial state',
      build: () async => CounterBloc(repo),
      state: (bloc) => bloc.states.count,
      expect: [0],
    );

    rxBlocTest<CounterBlocType, int>(
      'Incrementing value',
      build: () async {
        when(repo.increment()).thenAnswer((_) async => 1);
        return CounterBloc(repo);
      },
      act: (bloc) async => bloc.events.increment(),
      state: (bloc) => bloc.states.count,
      expect: [0, 1],
    );

    rxBlocTest<CounterBlocType, int>(
      'Decrementing value',
      build: () async {
        when(repo.decrement()).thenAnswer((_) async => -1);
        return CounterBloc(repo);
      },
      act: (bloc) async => bloc.events.decrement(),
      state: (bloc) => bloc.states.count,
      expect: [0, -1],
    );

    rxBlocTest<CounterBlocType, int>(
      'Increment and decrement value',
      build: () async {
        when(repo.increment()).thenAnswer((_) async => 1);
        when(repo.decrement()).thenAnswer((_) async => 0);
        return CounterBloc(repo);
      },
      act: (bloc) async {
        bloc.events.increment();
        bloc.events.decrement();
      },
      state: (bloc) => bloc.states.count,
      expect: [0, 1, 0],
    );

    rxBlocTest<CounterBlocType, String>(
      'Error handling',
      build: () async {
        when(repo.increment()).thenAnswer(
          (_) => Future.error('test error msg'),
        );
        return CounterBloc(repo);
      },
      act: (bloc) async {
        bloc.states.count.listen((event) {});
        bloc.events.increment();
      },
      state: (bloc) => bloc.states.errors,
      expect: ['Exception: test error msg'],
    );

    rxBlocTest<CounterBlocType, bool>(
      'Loading state',
      build: () async {
        when(repo.increment()).thenAnswer((_) async => 1);
        return CounterBloc(repo);
      },
      act: (bloc) async {
        bloc.states.count.listen((event) {});
        bloc.events.increment();
      },
      state: (bloc) => bloc.states.isLoading,
      expect: [false, true, false],
    );
  });
}
