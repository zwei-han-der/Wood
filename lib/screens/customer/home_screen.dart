import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/product_service.dart';
import '../../models/product.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos de Lenha'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navegar para tela do carrinho (implementar depois)
            },
          ),
        ],
      ),
      body: Consumer<ProductService>(
        builder: (context, productService, child) {
          final produtos = productService.produtos;
          if (produtos.isEmpty) {
            productService.carregarProdutos();
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (context, index) {
              final produto = produtos[index];
              return ProductCard(produto: produto);
            },
          );
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product produto;
  const ProductCard({required this.produto, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: produto.imagens.isNotEmpty
            ? Image.network(
                produto.imagens.first,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image, size: 56),
        title: Text(produto.nome),
        subtitle: Text('R\$ ${produto.preco.toStringAsFixed(2)}'),
        trailing: IconButton(
          icon: const Icon(Icons.add_shopping_cart),
          onPressed: () {
            // Adicionar ao carrinho (implementar depois)
          },
        ),
        onTap: () {
          // Navegar para detalhes do produto (implementar depois)
        },
      ),
    );
  }
}
