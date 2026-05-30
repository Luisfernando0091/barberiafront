import 'package:flutter/material.dart';

import '../../data/datasources/dashboard_remote_datasource.dart';
import '../../data/repositories/dashboard_repository_impl.dart';
import '../../domain/entities/dashboard_entity.dart';
import '../../domain/usecases/get_dashboard_usecase.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardEntity? dashboard;

  bool isLoading = false;

  Future<void> loadDashboard() async {
    try {
      isLoading = true;
      notifyListeners();

      final useCase = GetDashboardUseCase(
        DashboardRepositoryImpl(DashboardRemoteDataSourceImpl()),
      );

      dashboard = await useCase();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
