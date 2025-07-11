import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/product_service.dart';
import '../../models/product.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Produtos de Lenha'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navegar para tela de cadastro/edição de produto (implementar depois)
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
              return AdminProductCard(produto: produto);
            },
          );
        },
      ),
    );
  }
}

class AdminProductCard extends StatelessWidget {
  final Product produto;
  const AdminProductCard({required this.produto, super.key});

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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Editar produto (implementar depois)
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                // Remover produto
                Provider.of<ProductService>(
                  context,
                  listen: false,
                ).removerProduto(produto.id);
              },
            ),
          ],
        ),
        onTap: () {
          // Visualizar detalhes do produto (opcional)
        },
      ),
    );
  }
}
