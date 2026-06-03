class Client {
  final String id;
  final String nombres;
  final String telefono;
  final String? email;

  Client({
    required this.id,
    required this.nombres,
    required this.telefono,
    this.email,
  });
}
