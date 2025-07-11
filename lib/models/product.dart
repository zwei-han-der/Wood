/// Modelo de produto para o sistema de e-commerce de lenha.
class Product {
  final String id;
  final String nome;
  final String descricao;
  final double preco;
  final List<String> imagens;
  final int estoque;

  Product({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.preco,
    required this.imagens,
    required this.estoque,
  });

  // Construtor a partir de um Map (ex: Firestore)
  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
      preco: (map['preco'] ?? 0).toDouble(),
      imagens: List<String>.from(map['imagens'] ?? []),
      estoque: map['estoque'] ?? 0,
    );
  }

  // Converter para Map (ex: salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'descricao': descricao,
      'preco': preco,
      'imagens': imagens,
      'estoque': estoque,
    };
  }
}
