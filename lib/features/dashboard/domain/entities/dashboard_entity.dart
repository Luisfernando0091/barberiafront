import 'package:equatable/equatable.dart';

class DashboardEntity extends Equatable {
  final int clients;
  final int employees;
  final int services;
  final int appointmentsToday;

  final double incomeToday;
  final double commissionsToday;
  final double netIncomeToday;

  final int lowStockProducts;

  final String? topEmployee;
  final String? topService;
  final String? topClient;

  const DashboardEntity({
    required this.clients,
    required this.employees,
    required this.services,
    required this.appointmentsToday,
    required this.incomeToday,
    required this.commissionsToday,
    required this.netIncomeToday,
    required this.lowStockProducts,
    required this.topEmployee,
    required this.topService,
    required this.topClient,
  });

  @override
  List<Object?> get props => [
    clients,
    employees,
    services,
    appointmentsToday,
    incomeToday,
    commissionsToday,
    netIncomeToday,
    lowStockProducts,
    topEmployee,
    topService,
    topClient,
  ];
}
