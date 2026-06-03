import '../../domain/entities/client.dart';
import '../../domain/repositories/client_repository.dart';
import '../datasources/client_remote_datasource.dart';

class ClientRepositoryImpl implements ClientRepository {
  final ClientRemoteDataSource remoteDataSource;

  ClientRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Client>> getClients() {
    return remoteDataSource.getClients();
  }

  @override
  Future<Client> createClient(Client client) {
    return remoteDataSource.createClient(client);
  }
}