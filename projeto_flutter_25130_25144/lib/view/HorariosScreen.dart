
import 'package:flutter/material.dart';

import 'package:projeto_flutter_25130_25144/model/monitor.dart';
import 'package:projeto_flutter_25130_25144/model/horario.dart';

class HorariosScreen extends StatelessWidget {
  final MonitorModel monitor;
  final List<HorarioModel> horariosExibidos;
  final DiaDaSemana? diaSelecionado;
  final bool mostrarTodos;

  const HorariosScreen({
    super.key,
    required this.monitor,
    required this.horariosExibidos,
    required this.mostrarTodos,
    this.diaSelecionado,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Horários de atendimento'),
      ),

      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: Column(
              children: [
                ClipOval(
                  child: monitor.foto.trim().isEmpty
                      ? Container(
                          width: 112,
                          height: 112,
                          color: tema.colorScheme.secondaryContainer,
                          child: const Icon(
                            Icons.person_rounded,
                            size: 64,
                          ),
                        )
                      : Image.network(
                          monitor.foto,
                          width: 112,
                          height: 112,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 112,
                              height: 112,
                              color: tema.colorScheme.secondaryContainer,
                              child: const Icon(
                                Icons.person_rounded,
                                size: 64,
                              ),
                            );
                          },
                        ),
                ),

                const SizedBox(height: 20),

                Text(
                  monitor.nome,
                  textAlign: TextAlign.center,
                  style: tema.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  monitor.disciplina,
                  textAlign: TextAlign.center,
                  style: tema.textTheme.titleMedium?.copyWith(
                    color: tema.colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  monitor.email,
                  textAlign: TextAlign.center,
                  style: tema.textTheme.bodyMedium?.copyWith(
                    color: tema.colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 16),

                Chip(
                  avatar: const Icon(Icons.schedule_rounded),
                  label: Text(
                    mostrarTodos
                        ? 'Todos os dias de atendimento'
                        : 'Atendimento: ${diaSelecionado!.label}',
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          Text(
            'Horários disponíveis',
            style: tema.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          if (horariosExibidos.isEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Icon(
                      Icons.event_busy_rounded,
                      size: 40,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Nenhum horário cadastrado para esta seleção.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            ...horariosExibidos.map(
              (horario) => Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: tema.colorScheme.primaryContainer,
                    child: Icon(
                      Icons.access_time_rounded,
                      color: tema.colorScheme.onPrimaryContainer,
                    ),
                  ),

                  title: Text(
                    mostrarTodos
                        ? horario.dia.label
                        : 'Atendimento',
                    style: tema.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${horario.horaInicio} – ${horario.horaFim}',
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Local: ${horario.local}',
                        ),
                      ],
                    ),
                  ),

                  isThreeLine: true,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
