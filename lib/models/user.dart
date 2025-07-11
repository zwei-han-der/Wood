/// Modelo de usuário para o sistema de e-commerce de lenha.
class UserModel {
  final String id;
  final String nome;
  final String email;
  final String role; // 'customer' ou 'admin'

  UserModel({
    required this.id,
    required this.nome,
    required this.email,
    required this.role,
  });

  // Construtor a partir de um Map (ex: Firestore)
  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      nome: map['nome'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'customer',
    );
  }

  // Converter para Map (ex: salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {'nome': nome, 'email': email, 'role': role};
  }
}
