import 'package:flutter/foundation.dart';

import 'package:projeto_flutter_25130_25144/model/horario.dart';
import 'package:projeto_flutter_25130_25144/model/monitor.dart';

class MonitorViewModel extends ChangeNotifier {
  final List<MonitorModel> _monitores;

  DiaDaSemana? _diaSelecionado;
  bool _mostrarTodos = false;

  MonitorViewModel(List<MonitorModel> monitores)
      : _monitores = List.unmodifiable(monitores);

  DiaDaSemana? get diaSelecionado => _diaSelecionado;
  bool get mostrarTodos => _mostrarTodos;

  List<MonitorModel> get monitoresExibidos {
    if (!_mostrarTodos && _diaSelecionado == null) {
      return [];
    }

    if (_mostrarTodos) {
      return _monitores;
    }

    return _monitores.where((monitor) {
      return monitor.horarios.any(
        (horario) => horario.dia == _diaSelecionado,
      );
    }).toList();
  }

  void selecionarDia(DiaDaSemana dia) {
    _diaSelecionado = dia;
    _mostrarTodos = false;

    notifyListeners();
  }

  void selecionarTodos() {
    _diaSelecionado = null;
    _mostrarTodos = true;

    notifyListeners();
  }

  List<HorarioModel> horariosDoMonitor(MonitorModel monitor) {
    if (_mostrarTodos) {
      return monitor.horarios;
    }

    final dia = _diaSelecionado;

    if (dia == null) {
      return [];
    }

    return monitor.horariosDoDia(dia);
  }
}