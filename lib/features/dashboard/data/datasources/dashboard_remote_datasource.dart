import '../../../../core/network/dio_client.dart';

abstract class DashboardRemoteDataSource {
  Future<Map<String, dynamic>> getDashboard();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  @override
  Future<Map<String, dynamic>> getDashboard() async {
    final response = await DioClient.dio.get('/dashboard');

    print('===== DASHBOARD RESPONSE =====');
    print(response.data);

    return Map<String, dynamic>.from(response.data);
  }
}
