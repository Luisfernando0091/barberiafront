import 'package:flutter/material.dart';

import '../../domain/entities/client.dart';
import '../../domain/usecases/get_clients_usecase.dart';

class ClientProvider extends ChangeNotifier {
  final GetClientsUseCase getClientsUseCase;

  ClientProvider(this.getClientsUseCase);

  bool isLoading = false;

  List<Client> clients = [];

  Future<void> loadClients() async {
    if (clients.isNotEmpty) return;

    isLoading = true;
    notifyListeners();

    clients = await getClientsUseCase();

    isLoading = false;
    notifyListeners();
  }

  String search = '';
  List<Client> get filteredClients {
    if (search.isEmpty) return clients;
    return clients.where((client) {
      return client.nombres.toLowerCase().contains(
        search.toLowerCase(),
        );
    }).toList();
 
    
  }

  void addClient(Client client) {
    clients.add(client);
    debugPrint('CLIENTE AGREGADO: ${client.nombres}');
    debugPrint('TOTAL CLIENTES: ${clients.length}');
    notifyListeners();
  }

//ACTUALIZAR
  void updateClient(Client client) {
  final index = clients.indexWhere(
    (c) => c.id == client.id,
  );

  if (index != -1) {
    clients[index] = client;
    notifyListeners();
  }
}

  void searchClients(String query) {
    search = query;
    notifyListeners();
  }

}
