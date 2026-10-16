
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projeto_flutter_25130_25144/data/mock_monitor.dart';
import 'package:projeto_flutter_25130_25144/viewmodel/monitorViewmodel.dart';
import 'package:projeto_flutter_25130_25144/router/approuter.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MonitorViewModel(monitoresMock),
      child: const MeuApp(),
    ),
  );
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Monitores DCOMP',
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
