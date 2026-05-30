import '../../domain/entities/client.dart';
import '../../data/models/client_model.dart';
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
      nombres: json['nombres'],
      telefono: json['telefono'],
      email: json['email'],
    );
  }
}
