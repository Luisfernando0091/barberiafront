import '../models/client_model.dart';

class ClientRemoteDataSource {
  Future<List<ClientModel>> getClients() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      ClientModel(
        id: 1,
        nombres: 'Fernando López',
        telefono: '999888777',
        email: 'fernando@gmail.com',
      ),
      ClientModel(
        id: 2,
        nombres: 'Carlos Díaz',
        telefono: '987654321',
        email: 'carlos@gmail.com',
      ),
    ];
  }
}
