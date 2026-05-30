import 'package:barber_admin/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// AUTH
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/providers/auth_provider.dart';

// DASHBOARD
import 'features/dashboard/presentation/providers/dashboard_provider.dart';

// CLIENTS
import 'features/clients/data/datasources/client_remote_datasource.dart';
import 'features/clients/data/repositories/client_repository_impl.dart';
import 'features/clients/domain/usecases/get_clients_usecase.dart';
import 'features/clients/presentation/providers/client_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        ChangeNotifierProvider(create: (_) => DashboardProvider()),

        ChangeNotifierProvider(
          create: (_) => ClientProvider(
            GetClientsUseCase(ClientRepositoryImpl(ClientRemoteDataSource())),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Barber Admin',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),

      // IMPORTANTE
      home: const LoginPage(),
    );
  }
}
