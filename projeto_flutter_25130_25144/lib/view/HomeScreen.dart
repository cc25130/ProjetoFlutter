
import 'package:flutter/material.dart';

import 'package:projeto_flutter_25130_25144/model/monitor.dart';
import 'package:projeto_flutter_25130_25144/model/horario.dart';

class HomeScreen extends StatefulWidget {
  final List<MonitorModel> monitores;
  final DiaDaSemana? diaSelecionado;
  final bool mostrarTodos;

  final ValueChanged<DiaDaSemana?> onSelecionarDia;
  final ValueChanged<MonitorModel> onAbrirMonitor;

  const HomeScreen({
    super.key,
    required this.monitores,
    required this.diaSelecionado,
    required this.mostrarTodos,
    required this.onSelecionarDia,
    required this.onAbrirMonitor,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      viewportFraction: 0.78,
    );
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.diaSelecionado != widget.diaSelecionado ||
        oldWidget.mostrarTodos != widget.mostrarTodos) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _pageController.hasClients) {
          _pageController.jumpToPage(0);
        }
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String get _titulo {
    if (widget.mostrarTodos) {
      return 'Todos os monitores';
    }

    return 'Monitores de ${widget.diaSelecionado!.label}';
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitores DCOMP'),
      ),

      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: tema.colorScheme.primaryContainer,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.school_rounded,
                      size: 38,
                      color: tema.colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Monitores acadêmicos',
                      style: tema.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: tema.colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Consulte os horários de atendimento',
                      style: tema.textTheme.bodySmall?.copyWith(
                        color: tema.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),

              for (final dia in DiaDaSemana.values)
                ListTile(
                  leading: const Icon(Icons.calendar_today_rounded),
                  title: Text(dia.label),
                  selected: !widget.mostrarTodos &&
                      widget.diaSelecionado == dia,
                  onTap: () {
                    Navigator.pop(context);
                    widget.onSelecionarDia(dia);
                  },
                ),

              const Divider(),

              ListTile(
                leading: const Icon(Icons.groups_rounded),
                title: const Text('Todos'),
                selected: widget.mostrarTodos,
                onTap: () {
                  Navigator.pop(context);
                  widget.onSelecionarDia(null);
                },
              ),
            ],
          ),
        ),
      ),

      body: !widget.mostrarTodos && widget.diaSelecionado == null
          ? _buildEstadoInicial(context)
          : widget.monitores.isEmpty
              ? _buildEstadoVazio(context)
              : _buildCarrossel(context),
    );
  }

  Widget _buildEstadoInicial(BuildContext context) {
    final tema = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_month_rounded,
              size: 72,
              color: tema.colorScheme.primary,
            ),
            const SizedBox(height: 20),
            Text(
              'Encontre seu monitor',
              textAlign: TextAlign.center,
              style: tema.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Abra o menu lateral e selecione um dia da semana '
              'ou Todos para consultar os monitores disponíveis.',
              textAlign: TextAlign.center,
              style: tema.textTheme.bodyLarge?.copyWith(
                color: tema.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstadoVazio(BuildContext context) {
    final tema = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.event_busy_rounded,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhum monitor encontrado',
              textAlign: TextAlign.center,
              style: tema.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text(
              'Não há monitores cadastrados para esta seleção.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarrossel(BuildContext context) {
    final tema = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _titulo,
                    style: tema.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${widget.monitores.length} '
                    '${widget.monitores.length == 1 ? 'monitor encontrado' : 'monitores encontrados'}',
                    style: tema.textTheme.bodyMedium?.copyWith(
                      color: tema.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.monitores.length,
                itemBuilder: (context, index) {
                  final monitor = widget.monitores[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 12,
                    ),
                    child: _MonitorCard(
                      monitor: monitor,
                      onTap: () => widget.onAbrirMonitor(monitor),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.swipe_rounded,
                    color: tema.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Deslize para visualizar outros monitores',
                    style: tema.textTheme.bodySmall?.copyWith(
                      color: tema.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MonitorCard extends StatelessWidget {
  final MonitorModel monitor;
  final VoidCallback onTap;

  const _MonitorCard({
    required this.monitor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: monitor.foto.trim().isEmpty
                    ? Container(
                        width: 132,
                        height: 132,
                        color: tema.colorScheme.secondaryContainer,
                        child: const Icon(
                          Icons.person_rounded,
                          size: 64,
                        ),
                      )
                    : Image.network(
                        monitor.foto,
                        width: 132,
                        height: 132,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 132,
                            height: 132,
                            color: tema.colorScheme.secondaryContainer,
                            child: const Icon(
                              Icons.person_rounded,
                              size: 64,
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 24),

              Text(
                monitor.nome,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: tema.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),


              const SizedBox(height: 24),

              Text(
                'Ver horários  →',
                style: tema.textTheme.labelLarge?.copyWith(
                  color: tema.colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
