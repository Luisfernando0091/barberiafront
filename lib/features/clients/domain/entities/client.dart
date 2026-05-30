class Client {
  final int id;
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
