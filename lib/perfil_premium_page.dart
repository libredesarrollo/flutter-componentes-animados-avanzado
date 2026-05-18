import 'package:flutter/material.dart';

class PerfilPremiumPage extends StatelessWidget {
  const PerfilPremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // 1. AppBar expandible con efecto parallax
          SliverAppBar(
            expandedHeight: 280.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Ana García'),
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://picsum.photos/800/600?random=1',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      throw error; // Ensures the error message is printed to the console.
                    },
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black54],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2. Tarjeta de estadísticas (widget normal adaptado)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatItem(label: 'Publicaciones', value: '248'),
                  _StatItem(label: 'Seguidores', value: '12.4K'),
                  _StatItem(label: 'Siguiendo', value: '391'),
                ],
              ),
            ),
          ),

          // 3. Encabezado sticky para la galería
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyHeaderDelegate(
              title: 'Galería de Fotos',
              color: Colors.deepPurple,
            ),
          ),

          // 4. Galería de fotos en cuadrícula
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      'https://picsum.photos/200/200?random=${index + 10}',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        throw error; // Ensures the error message is printed to the console.
                      },
                    ),
                  );
                },
                childCount: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar para mostrar estadísticas
class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(label, style: TextStyle(color: Colors.grey.shade600)),
      ],
    );
  }
}

class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final Color color;

  _StickyHeaderDelegate({required this.title, required this.color});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final progress = shrinkOffset / (maxExtent - minExtent);

    return Container(
      color: Color.lerp(color.withValues(alpha: 0.7), color, progress),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18 - (4 * progress),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  double get maxExtent => 80.0;

  @override
  double get minExtent => 50.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
