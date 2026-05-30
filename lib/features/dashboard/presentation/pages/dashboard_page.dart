import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dashboard_provider.dart';
import 'package:barber_admin/core/widgets/app_drawer.dart';
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<DashboardProvider>().loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();

    if (provider.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final dashboard = provider.dashboard;

    if (dashboard == null) {
      return const Scaffold(
        body: Center(child: Text('No hay información')),
      );
    }

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

   return Scaffold(
        drawer: const AppDrawer(),

        backgroundColor: colorScheme.surfaceContainerLowest,

        appBar: AppBar(
          title: const Text('Dashboard'),
          centerTitle: false,
          backgroundColor: colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Divider(
              height: 1,
              color: colorScheme.outlineVariant,
            ),
          ),
        ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Resumen del día ──────────────────────────────
          _SectionLabel(label: 'Resumen del día', textTheme: textTheme),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  icon: Icons.calendar_today_rounded,
                  label: 'Citas hoy',
                  value: dashboard.appointmentsToday.toString(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  icon: Icons.attach_money_rounded,
                  label: 'Ingreso hoy',
                  value: 'S/ ${dashboard.incomeToday}',
                  valueColor: const Color(0xFF0F6E56),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  icon: Icons.trending_up_rounded,
                  label: 'Utilidad hoy',
                  value: 'S/ ${dashboard.netIncomeToday}',
                  valueColor: const Color(0xFF0F6E56),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // ── General ──────────────────────────────────────
          _SectionLabel(label: 'General', textTheme: textTheme),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _MetricCard(
                  icon: Icons.group_rounded,
                  label: 'Clientes',
                  value: dashboard.clients.toString(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  icon: Icons.badge_rounded,
                  label: 'Empleados',
                  value: dashboard.employees.toString(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _MetricCard(
                  icon: Icons.design_services_rounded,
                  label: 'Servicios',
                  value: dashboard.services.toString(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _LowStockBanner(count: dashboard.lowStockProducts),

          const SizedBox(height: 20),

          // ── Top del mes ──────────────────────────────────
          _SectionLabel(label: 'Top del mes', textTheme: textTheme),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _TopCard(
                  icon: Icons.emoji_events_rounded,
                  label: 'Empleado',
                  name: dashboard.topEmployee ?? '-',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _TopCard(
                  icon: Icons.favorite_rounded,
                  label: 'Cliente',
                  name: dashboard.topClient ?? '-',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _TopCard(
                  icon: Icons.star_rounded,
                  label: 'Servicio',
                  name: dashboard.topService ?? '-',
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

// ── Subwidgets ────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label, required this.textTheme});

  final String label;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.outline,
        letterSpacing: 0.8,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: colorScheme.outline),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: valueColor ?? colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

class _LowStockBanner extends StatelessWidget {
  const _LowStockBanner({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFFAEEDA),
        border: Border.all(color: const Color(0xFFFAC775), width: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded,
              size: 20, color: Color(0xFF854F0B)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Stock bajo',
                style: TextStyle(fontSize: 11, color: Color(0xFF854F0B)),
              ),
              Text(
                '$count productos',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF633806),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TopCard extends StatelessWidget {
  const _TopCard({
    required this.icon,
    required this.label,
    required this.name,
  });

  final IconData icon;
  final String label;
  final String name;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 13, color: colorScheme.outline),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEDFE),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              '⭐ Top',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0xFF3C3489),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}