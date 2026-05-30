import 'package:barber_admin/features/auth/presentation/providers/auth_provider.dart';
import 'package:barber_admin/features/clients/presentation/pages/client_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.currentUser;

    debugPrint('DRAWER USER => ${user?.name}');
    debugPrint('DRAWER EMAIL => ${user?.email}');
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user?.name ?? 'Usuario'),
            accountEmail: Text(user?.email ?? ''),
            currentAccountPicture: const CircleAvatar(
              child: Icon(Icons.person, size: 40),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.people_outline),
            title: const Text('Clientes'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ClientPage()),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.calendar_month_outlined),
            title: const Text('Citas'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.content_cut_outlined),
            title: const Text('Servicios'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.badge_outlined),
            title: const Text('Empleados'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.inventory_2_outlined),
            title: const Text('Inventario'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.point_of_sale_outlined),
            title: const Text('Ventas'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Mi Perfil'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Configuración'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const Spacer(),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              authProvider.logout();

              Navigator.pop(context);

              // Después agregaremos:
              // Navigator.pushAndRemoveUntil(...)
              // para volver al Login
            },
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
