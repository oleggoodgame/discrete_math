import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:discrete_math/core/graph/presentation/bloc/graph_bloc/graphs_bloc.dart';
import 'package:discrete_math/core/graph/presentation/screen/graphs_screen.dart';

class _FakeCubit extends Cubit<GraphsState> {
  _FakeCubit(super.initialState);

  Future<void> loadGraphs() async {} // нічого не робить
}

void main() {
  testWidgets('показує CircularProgressIndicator коли GraphsLoading', (
    tester,
  ) async {
    final fakeCubit = _FakeCubit(GraphsLoading()); // ← задаємо стан тут

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<GraphsCubit>.value(
          value: fakeCubit as GraphsCubit, // приводимо тип
          child: const GraphsScreen(),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('показує "There is no graphs" коли список порожній', (
    tester,
  ) async {
    final fakeCubit = _FakeCubit(GraphsLoaded(const []));

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<GraphsCubit>.value(
          value: fakeCubit as GraphsCubit,
          child: const GraphsScreen(),
        ),
      ),
    );

    expect(find.text('There is no graphs'), findsOneWidget);
  });
}