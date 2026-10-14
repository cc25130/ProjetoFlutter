
import 'package:flutter/foundation.dart';

import 'package:projeto_flutter_25130_25144/model/monitor.dart';
import 'package:projeto_flutter_25130_25144/model/horario.dart';

class MonitorViewModel extends ChangeNotifier {
  final List<MonitorModel> _monitores;

  DiaDaSemana? diaSelecionado;
  bool mostrarTodos = false;

  MonitorViewModel(List<MonitorModel> monitores)
      : _monitores = List.unmodifiable(monitores);

  DiaDaSemana? get DiaSelecionado => diaSelecionado;

  bool get MostrarTodos => mostrarTodos;


  List<MonitorModel> get monitoresExibidos {

    if (!mostrarTodos && diaSelecionado == null) { // Dia não selecionado
      return [];
    }

 
    if (mostrarTodos) { // Todos selecionado
      return _monitores;
    }


    return _monitores.where((monitor) { // Retorna todos os horários de cada monitor com monitoria naquele dia
      return monitor.horarios.any(
        (horario) => horario.dia == diaSelecionado,
      );
    }).toList();
  }

  void selecionarDia(DiaDaSemana dia) {
    diaSelecionado = dia;
    mostrarTodos = false;

    notifyListeners();
  }

  void selecionarTodos() {
    diaSelecionado = null;
    mostrarTodos = true;

    notifyListeners();
  }

  
  List<HorarioModel> horariosDoMonitor(MonitorModel monitor) {
    if (mostrarTodos) {
      return monitor.horarios;
    }

    final dia = diaSelecionado;

    if (dia == null) {
      return [];
    }

    return monitor.horariosDoDia(dia);
  }
}