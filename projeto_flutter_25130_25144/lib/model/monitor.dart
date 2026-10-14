import 'package:projeto_flutter_25130_25144/model/horario.dart';

class MonitorModel {
  final String nome;
  final String foto;
  final String disciplina;
  final String email;
  final List<HorarioModel> horarios;

  const MonitorModel({
    required this.nome,
    required this.foto,
    required this.disciplina,
    required this.email,
    required this.horarios,
  });

  /// Método utilitário conveniente para pegar apenas os horários de um dia específico
  List<HorarioModel> horariosDoDia(DiaDaSemana dia) {
    return horarios.where((h) => h.dia == dia).toList();
  }
}