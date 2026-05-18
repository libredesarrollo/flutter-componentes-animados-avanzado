import 'package:flutter/material.dart';

class HeroDetailPage extends StatelessWidget {
  final int productId;

  const HeroDetailPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product-image-$productId',
                child: Image.network(
                  'https://picsum.photos/300/300?random=$productId',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Producto #${productId + 1}',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Descripción detallada del producto. Aquí va toda la información que necesita el usuario para tomar una decisión de compra informada.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Características:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const ListTile(
                    leading: Icon(Icons.check, color: Colors.green),
                    title: Text('Calidad Premium'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.check, color: Colors.green),
                    title: Text('Envío gratis'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.check, color: Colors.green),
                    title: Text('Garantía de 1 año'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
