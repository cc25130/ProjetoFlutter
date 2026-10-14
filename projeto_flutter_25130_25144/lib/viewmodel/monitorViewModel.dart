import 'package:projeto_flutter_25130_25144/model/horario.dart';

enum FiltroMenu {
  nenhum('Nenhum'), // Estado Neutro Inicial
  segunda('Segunda-feira'),
  terca('Terça-feira'),
  quarta('Quarta-feira'),
  quinta('Quinta-feira'),
  sexta('Sexta-feira'),
  todos('Todos os Monitores');

  final String titulo;
  const FiltroMenu(this.titulo);

  /// Converte o filtro do menu para o Enum DiaDaSemana correspondente (se houver)
  DiaDaSemana? get dia {
    switch (this) {
      case FiltroMenu.segunda: return DiaDaSemana.segunda;
      case FiltroMenu.terca: return DiaDaSemana.terca;
      case FiltroMenu.quarta: return DiaDaSemana.quarta;
      case FiltroMenu.quinta: return DiaDaSemana.quinta;
      case FiltroMenu.sexta: return DiaDaSemana.sexta;
      default: return null;
    }
  }
}