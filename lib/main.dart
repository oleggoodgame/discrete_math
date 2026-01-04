import 'package:discrete_math/navigation/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//https://banatube.medium.com/mastering-flutter-custompainter-the-complete-developers-guide-f9b1e8575e6c
//https://medium.com/@punithsuppar7795/exploring-the-interactive-viewer-in-flutter-29fa05f786a5
void main() {
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(routerConfig: router);
  }
}
