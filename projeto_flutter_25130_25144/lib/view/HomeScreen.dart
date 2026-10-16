import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:projeto_flutter_25130_25144/model/horario.dart';
import 'package:projeto_flutter_25130_25144/model/monitor.dart';
import 'package:projeto_flutter_25130_25144/viewmodel/monitorViewmodel.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<MonitorModel> onAbrirMonitor;

  const HomeScreen({
    super.key,
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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _titulo(MonitorViewModel vm) {
    if (vm.mostrarTodos) {
      return 'Todos os monitores';
    }
    return 'Monitores de ${vm.diaSelecionado!.label}';
  }

  void _resetarCarrossel() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _pageController.hasClients) {
        _pageController.jumpToPage(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context);
    final vm = context.watch<MonitorViewModel>();
    final monitores = vm.monitoresExibidos;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Monitores DCOMP',
                      style: tema.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Selecione um dia',
                      style: tema.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              for (final dia in DiaDaSemana.values)
                ListTile(
                  title: Text(dia.label),
                  selected: !vm.mostrarTodos && vm.diaSelecionado == dia,
                  onTap: () {
                    Navigator.pop(context);
                    context.read<MonitorViewModel>().selecionarDia(dia);
                    _resetarCarrossel();
                  },
                ),
              const Divider(),
              ListTile(
                title: const Text('Todos'),
                selected: vm.mostrarTodos,
                onTap: () {
                  Navigator.pop(context);
                  context.read<MonitorViewModel>().selecionarTodos();
                  _resetarCarrossel();
                },
              ),
            ],
          ),
        ),
      ),
      body: !vm.mostrarTodos && vm.diaSelecionado == null
          ? _buildEstadoInicial(context)
          : monitores.isEmpty
              ? _buildEstadoVazio(context)
              : _buildCarrossel(context, vm, monitores),
    );
  }

  Widget _buildEstadoInicial(BuildContext context) {
    final tema = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Encontre seu monitor',
              style: tema.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Abra o menu lateral para selecionar um dia da semana.',
              textAlign: TextAlign.center,
              style: tema.textTheme.bodyMedium,
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
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nenhum monitor disponível',
              style: tema.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Não há monitores para esta seleção.',
              style: tema.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarrossel(
    BuildContext context,
    MonitorViewModel vm,
    List<MonitorModel> monitores,
  ) {
    final tema = Theme.of(context);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              _titulo(vm),
              style: tema.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: monitores.length,
              itemBuilder: (context, index) {
                final monitor = monitores[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: _MonitorCard(
                    monitor: monitor,
                    onTap: () => widget.onAbrirMonitor(monitor),
                  ),
                );
              },
            ),
          ),
        ],
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
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: tema.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: monitor.foto.trim().isEmpty
                    ? Container(
                        width: 120,
                        height: 120,
                        color: tema.colorScheme.surfaceContainerHigh,
                      )
                    : Image.network(
                        monitor.foto,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 120,
                            height: 120,
                            color: tema.colorScheme.surfaceContainerHigh,
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
                style: tema.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Ver horários',
                style: tema.textTheme.labelMedium?.copyWith(
                  color: tema.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}