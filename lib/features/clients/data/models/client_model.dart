import '../../domain/entities/client.dart';

class ClientModel extends Client {
  ClientModel({
    required super.id,
    required super.nombres,
    required super.telefono,
    super.email,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      nombres: json['name'], // <- cambio
      telefono: json['phone'], // <- cambio
      email: json['email'],
    );
  }
}
