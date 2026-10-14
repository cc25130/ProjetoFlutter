```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/monitor_view_model.dart';
import 'data/monitores_mock.dart';
import 'router/app_router.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MonitorViewModel(monitoresMock),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Horários de Monitoria DCOMP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
