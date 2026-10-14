enum DiaDaSemana {
  segunda('Segunda-feira'),
  terca('Terça-feira'),
  quarta('Quarta-feira'),
  quinta('Quinta-feira'),
  sexta('Sexta-feira');

  final String label;
  const DiaDaSemana(this.label);
}

class HorarioModel {
  final DiaDaSemana dia;
  final String horaInicio;
  final String horaFim;
  final String local;

  const HorarioModel({
    required this.dia,
    required this.horaInicio,
    required this.horaFim,
    required this.local,
  });
}