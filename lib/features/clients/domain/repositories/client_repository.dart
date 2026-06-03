import '../entities/client.dart';
abstract class ClientRepository {
  Future<List<Client>> getClients();
  Future<Client> createClient(Client client);
}