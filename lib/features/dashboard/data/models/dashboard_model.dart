import '../../domain/entities/dashboard_entity.dart';

class DashboardModel extends DashboardEntity {
  const DashboardModel({
    required super.clients,
    required super.employees,
    required super.services,
    required super.appointmentsToday,
    required super.incomeToday,
    required super.commissionsToday,
    required super.netIncomeToday,
    required super.lowStockProducts,
    required super.topEmployee,
    required super.topService,
    required super.topClient,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      clients: json['clients'] ?? 0,
      employees: json['employees'] ?? 0,
      services: json['services'] ?? 0,
      appointmentsToday: json['appointments_today'] ?? 0,

      incomeToday: double.tryParse(json['income_today'].toString()) ?? 0,

      commissionsToday:
          double.tryParse(json['commissions_today'].toString()) ?? 0,

      netIncomeToday: double.tryParse(json['net_income_today'].toString()) ?? 0,

      lowStockProducts: json['low_stock_products'] ?? 0,

      topEmployee: json['top_employee']?.toString(),

      topService: json['top_service']?.toString(),

      topClient: json['top_client']?.toString(),
    );
  }
}
