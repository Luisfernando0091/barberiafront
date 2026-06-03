import 'package:flutter/material.dart';

import '../../../../core/network/dio_client.dart';
import '../models/client_model.dart';
import '../../domain/entities/client.dart';
class ClientRemoteDataSource {
  Future<List<ClientModel>> getClients() async {
   

    final response = await DioClient.dio.get('/clients');

    final List data = response.data;

    return data.map((json) => ClientModel.fromJson(json)).toList();
  }
  Future<ClientModel> createClient(Client client) async {
    debugPrint('POST CLIENTE EJECUTADO');

    final response = await DioClient.dio.post(
      '/clients',
      data: {
        'name': client.nombres,
        'phone': client.telefono,
        'email': client.email,
      },
    );
    return ClientModel.fromJson(
      response.data['client'],
    );
  }
//METODO DE ELIMINAR CLIENTE
  Future<void> deleteClient(String id) async {
      await DioClient.dio.delete(
        '/clients/$id',
      );
    }

    //METODO DE ACTUALIZAR CLIENTE

  Future<ClientModel> updateClient(Client client) async {
    final response = await DioClient.dio.put(
      '/clients/${client.id}',
      data: {
        'name': client.nombres,
        'phone': client.telefono,
        'email': client.email,
      },
    );

    return ClientModel.fromJson(
      response.data['client'],
    );
  }
}
