import 'package:go_router/go_router.dart';

import 'package:projeto_flutter_25130_25144/model/monitor.dart';
import 'package:projeto_flutter_25130_25144/view/HomeScreen.dart';
import 'package:projeto_flutter_25130_25144/view/HorariosScreen.dart';
import 'package:projeto_flutter_25130_25144/view/SplashScreen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeScreen(
        onAbrirMonitor: (monitor) {
          context.push('/detalhes', extra: monitor);
        },
      ),
    ),
    GoRoute(
      path: '/detalhes',
      builder: (context, state) {
        final monitor = state.extra as MonitorModel;
        return HorariosScreen(monitor: monitor);
      },
    ),
  ],
);